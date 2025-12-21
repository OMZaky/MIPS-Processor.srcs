library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.MIPS_Package.all;

entity Main_Module is
    Port ( 
        clk, rst   : in  STD_LOGIC; 
        writedata  : out STD_LOGIC_VECTOR(31 downto 0);
        dataadr    : out STD_LOGIC_VECTOR(31 downto 0);
        memwrite   : out STD_LOGIC
    );
end Main_Module;

architecture Structural of Main_Module is

    -- Internal Signals
    signal instr, readdata, pc_current : STD_LOGIC_VECTOR(31 downto 0);
    signal alu_result_int, write_data_int : STD_LOGIC_VECTOR(31 downto 0);
    
    -- Control Signals
    signal reg_dst, branch, mem_read, mem_to_reg, alu_src, reg_write, jump, zero, pcsrc, mem_write_int : STD_LOGIC;
    signal alu_op   : STD_LOGIC_VECTOR(1 downto 0);
    signal alu_ctrl : STD_LOGIC_VECTOR(3 downto 0);

    -- NOTE: No local component declarations needed. 
    -- All components (Main_Control, ALUControl, datapath, imem, dmem) 
    -- are now imported from MIPS_Package.

begin

    -- 1. Main Control Unit
    ctl: Main_Control port map(
        OpCode   => instr(31 downto 26),
        RegDst   => reg_dst,
        Jump     => jump,
        Branch   => branch,
        MemRead  => mem_read, 
        MemToReg => mem_to_reg,
        AluOp    => alu_op,
        MemWrite => mem_write_int,
        AluSrc   => alu_src,
        RegWrite => reg_write
    );

    -- 2. ALU Control Unit
    dec: ALUControl port map(
        ALUOp     => alu_op,
        Funct     => instr(5 downto 0),
        Operation => alu_ctrl
    );
    
    -- Branch Logic
    pcsrc <= branch and zero;

    -- 3. Datapath
    dp: datapath port map(
        clk          => clk,
        reset        => rst, 
        readdata     => readdata,
        instr        => instr,
        memtoreg     => mem_to_reg,
        pcsrc        => pcsrc,
        alusrc       => alu_src,
        regwrite     => reg_write,
        regdst       => reg_dst,
        aluoperation => alu_ctrl,
        zero         => zero,
        pc           => pc_current,
        jump         => jump,
        aluout       => alu_result_int,
        writedata    => write_data_int
    );
    
    -- 4. Instruction Memory
    -- Uses pc_current(7 downto 2) to get the 6-bit word index
    imem_inst: imem port map(
        a  => pc_current(7 downto 2), 
        rd => instr
    );
    
    -- 5. Data Memory
    dmem_inst: dmem port map(
        clk => clk,
        we  => mem_write_int,
        a   => alu_result_int,
        wd  => write_data_int,
        rd  => readdata
    );
    
    -- 6. Drive Outputs to Testbench
    writedata <= write_data_int;
    dataadr   <= alu_result_int;
    memwrite  <= mem_write_int;

end Structural;