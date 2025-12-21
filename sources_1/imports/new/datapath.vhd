library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MIPS_Package.all;

entity datapath is
    port(
        clk, reset   : in STD_LOGIC;
        readdata     : in STD_LOGIC_VECTOR(31 downto 0);
        instr        : in STD_LOGIC_VECTOR(31 downto 0);
        memtoreg     : in STD_LOGIC;
        pcsrc        : in STD_LOGIC;
        alusrc       : in STD_LOGIC;
        regwrite     : in STD_LOGIC;
        regdst       : in STD_LOGIC;
        aluoperation : in STD_LOGIC_VECTOR(3 downto 0);
        zero         : out STD_LOGIC;
        pc           : out STD_LOGIC_VECTOR(31 downto 0);
        jump         : in std_logic;
        aluout       : out STD_LOGIC_VECTOR(31 downto 0);
        writedata    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end datapath;

architecture struct of datapath is

    -- Internal Signals
    signal writereg: STD_LOGIC_VECTOR(4 downto 0);
    signal pcjump, pcnext, pcnextbr, pcplus4, pcbranch: STD_LOGIC_VECTOR(31 downto 0);
    signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
    signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);
    signal readdata1, readdata2 : STD_LOGIC_VECTOR(31 downto 0);

    -- Internal signals for outputs (replacing buffer)
    signal pc_int        : STD_LOGIC_VECTOR(31 downto 0);
    signal aluout_int    : STD_LOGIC_VECTOR(31 downto 0);
    signal writedata_int : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- 1. IF Stage: Instruction Fetch
    
    -- Adder: uses ports a, b, output
    pcadd1: adder port map(a => pc_int, b => X"00000004", output => pcplus4);
    
    -- SL2: uses ports a, o
    immsh: sl2 port map(a => signimm, o => signimmsh);
    
    -- Adder: uses ports a, b, output
    pcadd2: adder port map(a => pcplus4, b => signimmsh, output => pcbranch);
    
    -- Mux2: uses generic n, ports I1, I2, sel, output
    pcbrmux: mux2 generic map(n => 32) port map(I1 => pcplus4, I2 => pcbranch, sel => pcsrc, output => pcnextbr);
    
    pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";
    
    -- Mux2: uses generic n, ports I1, I2, sel, output
    pcmux: mux2 generic map(n => 32) port map(I1 => pcnextbr, I2 => pcjump, sel => jump, output => pcnext);

    -- Flopr: uses generic n, ports clk, reset, d, q
    pcreg: flopr generic map(n => 32) port map(clk => clk, reset => reset, d => pcnext, q => pc_int);


    -- 2. ID Stage: Decode & Register Read
    
    -- Mux2 for WriteReg (5 bits)
    wrmux: mux2 generic map(n => 5) port map(I1 => instr(20 downto 16), I2 => instr(15 downto 11), sel => regdst, output => writereg);

    -- RegisterFile
    regfile: RegisterFile port map(
        read_sel1  => instr(25 downto 21),  
        read_sel2  => instr(20 downto 16),  
        write_sel  => writereg,             
        write_ena  => regwrite,             
        clk        => clk,
        write_data => result,               
        data1      => readdata1,            
        data2      => readdata2             
    );
    
    signext: SignExtend port map(
        Input  => instr(15 downto 0),
        Output => signimm
    );


    -- 3. EX Stage: Execution
    
    -- Mux2 for ALUSrc
    srcbmux: mux2 generic map(n => 32) port map(I1 => readdata2, I2 => signimm, sel => alusrc, output => srcb);
    
    srca <= readdata1;

    alu: aluproj port map(
        data1   => srca,       
        data2   => srcb,
        aluop   => aluoperation,
        dataout => aluout_int,
        zflag   => zero
    );
    
    writedata_int <= readdata2;


    -- 4. WB Stage: Write Back
    
    -- Mux2 for MemToReg
    resmux: mux2 generic map(n => 32) port map(I1 => aluout_int, I2 => readdata, sel => memtoreg, output => result);

    -- Drive Outputs
    pc        <= pc_int;
    aluout    <= aluout_int;
    writedata <= writedata_int;

end struct;