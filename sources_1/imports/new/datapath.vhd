library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MIPS_Package.all;

entity datapath is
    port(
        clk, reset   : in STD_LOGIC;
        readdata     : in STD_LOGIC_VECTOR(31 downto 0);
        instr        : in STD_LOGIC_VECTOR(31 downto 0);
        memtoreg     : in STD_LOGIC_VECTOR(1 downto 0); 
        pcsrc        : in STD_LOGIC;
        alusrc       : in STD_LOGIC;
        regwrite     : in STD_LOGIC;
        regdst       : in STD_LOGIC_VECTOR(1 downto 0); 
        aluoperation : in STD_LOGIC_VECTOR(3 downto 0);
        jump         : in STD_LOGIC;
        jumpsrc      : in STD_LOGIC_VECTOR(1 downto 0); 
        regwrite2    : in STD_LOGIC;                    
        zero         : out STD_LOGIC;
        nflag        : out STD_LOGIC;                   
        pc           : out STD_LOGIC_VECTOR(31 downto 0);
        aluout       : out STD_LOGIC_VECTOR(31 downto 0);
        writedata    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end datapath;

architecture struct of datapath is

    signal writereg: STD_LOGIC_VECTOR(4 downto 0);
    signal pcjump, pcnext, pcnextbr, pcplus4, pcbranch: STD_LOGIC_VECTOR(31 downto 0);
    signal pc_jump_target: STD_LOGIC_VECTOR(31 downto 0); 
    signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
    signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);
    signal readdata1, readdata2 : STD_LOGIC_VECTOR(31 downto 0);
    signal writereg2 : STD_LOGIC_VECTOR(4 downto 0);
    signal writedata2: STD_LOGIC_VECTOR(31 downto 0);
    signal pc_int, aluout_int, writedata_int : STD_LOGIC_VECTOR(31 downto 0);

begin

    pcadd1: adder port map(a => pc_int, b => X"00000004", output => pcplus4);
    immsh: sl2 port map(a => signimm, o => signimmsh);
    pcadd2: adder port map(a => pcplus4, b => signimmsh, output => pcbranch);
    pcbrmux: mux2 generic map(n => 32) port map(I1 => pcplus4, I2 => pcbranch, sel => pcsrc, output => pcnextbr);
    pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";
    
    -- JUMP TARGET SELECTION
    with jumpsrc select pc_jump_target <=
        pcjump     when "00",
        readdata1  when "01", 
        readdata   when "10", 
        pcjump     when others;
    
    pcmux: mux2 generic map(n => 32) port map(I1 => pcnextbr, I2 => pc_jump_target, sel => jump, output => pcnext);
    pcreg: flopr generic map(n => 32) port map(clk => clk, reset => reset, d => pcnext, q => pc_int);

    with regdst select writereg <=
        instr(20 downto 16) when "00", 
        instr(15 downto 11) when "01", 
        "11111"             when "10", 
        instr(20 downto 16) when others;

    writereg2 <= instr(25 downto 21);
    writedata2 <= aluout_int; 

    regfile: RegisterFile port map(
        read_sel1  => instr(25 downto 21),  
        read_sel2  => instr(20 downto 16),  
        write_sel  => writereg,             
        write_ena  => regwrite,
        write_data => result,   
        write_sel2 => writereg2,
        write_ena2 => regwrite2,
        write_data2=> writedata2,
        clk        => clk,            
        data1      => readdata1,            
        data2      => readdata2             
    );
    
    signext: SignExtend port map(Input => instr(15 downto 0), Output => signimm);
    srcbmux: mux2 generic map(n => 32) port map(I1 => readdata2, I2 => signimm, sel => alusrc, output => srcb);
    srca <= readdata1;

    alu: aluproj port map(
        data1   => srca,       
        data2   => srcb,
        aluop   => aluoperation,
        dataout => aluout_int,
        zflag   => zero,
        nflag   => nflag
    );
    writedata_int <= readdata2;

    with memtoreg select result <=
        aluout_int  when "00",
        readdata    when "01",
        pcplus4     when "10",
        aluout_int  when others;

    pc <= pc_int; aluout <= aluout_int; writedata <= writedata_int;

end struct;