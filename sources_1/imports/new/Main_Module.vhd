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

    signal instr, readdata, pc_current : STD_LOGIC_VECTOR(31 downto 0);
    signal alu_result_int, write_data_int : STD_LOGIC_VECTOR(31 downto 0);
    
    signal reg_dst_vec   : STD_LOGIC_VECTOR(1 downto 0);
    signal mem_to_reg_vec: STD_LOGIC_VECTOR(1 downto 0);
    signal jump_src_vec  : STD_LOGIC_VECTOR(1 downto 0);
    
    signal branch, mem_read, alu_src, reg_write, jump, zero, nflag, pcsrc, mem_write_int, reg_write2 : STD_LOGIC;
    signal alu_op   : STD_LOGIC_VECTOR(1 downto 0);
    signal branch_op: STD_LOGIC_VECTOR(2 downto 0);
    signal alu_ctrl : STD_LOGIC_VECTOR(3 downto 0);

begin

    ctl: Main_Control port map(
        OpCode   => instr(31 downto 26),
        RegDst   => reg_dst_vec,
        MemToReg => mem_to_reg_vec,
        JumpSrc  => jump_src_vec,
        AluSrc   => alu_src,
        Jump     => jump,
        Branch   => branch,
        BranchOp => branch_op,
        AluOp    => alu_op,
        MemRead  => mem_read, 
        MemWrite => mem_write_int,
        RegWrite => reg_write,
        RegWrite2=> reg_write2
    );

    dec: ALUControl port map(
        ALUOp     => alu_op,
        Funct     => instr(5 downto 0),
        Operation => alu_ctrl
    );
    
    process(branch, branch_op, zero, nflag)
    begin
        if branch = '1' then
            case branch_op is
                when "000" => pcsrc <= zero;           -- BEQ
                when "001" => pcsrc <= not zero;       -- BNE
                when "010" => pcsrc <= nflag;          -- BLT
                when "011" => pcsrc <= not (zero or nflag); -- BGT
                when "100" => pcsrc <= zero or nflag;  -- BLE
                when others => pcsrc <= '0';
            end case;
        else
            pcsrc <= '0';
        end if;
    end process;

    dp: datapath port map(
        clk          => clk,
        reset        => rst, 
        readdata     => readdata,
        instr        => instr,
        memtoreg     => mem_to_reg_vec,
        pcsrc        => pcsrc,
        alusrc       => alu_src,
        regwrite     => reg_write,
        regdst       => reg_dst_vec,
        aluoperation => alu_ctrl,
        jump         => jump,
        jumpsrc      => jump_src_vec,
        regwrite2    => reg_write2,
        zero         => zero,
        nflag        => nflag,
        pc           => pc_current,
        aluout       => alu_result_int,
        writedata    => write_data_int
    );
    
    imem_inst: imem port map(
        a  => pc_current(7 downto 2), 
        rd => instr
    );
    
    dmem_inst: dmem port map(
        clk => clk,
        we  => mem_write_int,
        a   => alu_result_int,
        wd  => write_data_int,
        rd  => readdata
    );
    
    writedata <= write_data_int;
    dataadr   <= alu_result_int;
    memwrite  <= mem_write_int;

end Structural;