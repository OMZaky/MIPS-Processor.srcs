library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MIPS_Package.all;

entity MIPS_CPU is
    Port ( 
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        instr        : in  STD_LOGIC_VECTOR(31 downto 0);
        aluoperation : in  STD_LOGIC_VECTOR(3 downto 0);
        regwrite     : in  STD_LOGIC;
        zero         : out STD_LOGIC;
        aluout       : out STD_LOGIC_VECTOR(31 downto 0)
    );
end MIPS_CPU;

architecture Structural of MIPS_CPU is

    -- =========================================================================
    -- 1. ALIASES (Readable Names for Instruction Fields)
    -- =========================================================================
    alias opcode : std_logic_vector(5 downto 0) is instr(31 downto 26);
    alias rs     : std_logic_vector(4 downto 0) is instr(25 downto 21); -- Read Reg 1
    alias rt     : std_logic_vector(4 downto 0) is instr(20 downto 16); -- Read Reg 2
    alias rd     : std_logic_vector(4 downto 0) is instr(15 downto 11); -- Write Reg (R-Type)
    alias imm    : std_logic_vector(15 downto 0) is instr(15 downto 0); -- Immediate (I-Type)

    -- =========================================================================
    -- 2. INTERNAL SIGNALS
    -- =========================================================================
    signal read_data_1    : STD_LOGIC_VECTOR(31 downto 0);
    signal read_data_2    : STD_LOGIC_VECTOR(31 downto 0);
    signal alu_result     : STD_LOGIC_VECTOR(31 downto 0);
    signal sign_imm       : STD_LOGIC_VECTOR(31 downto 0);
    
    -- Mux Outputs (Wires prepared for Phase 2)
    signal write_reg_addr : STD_LOGIC_VECTOR(4 downto 0); 
    signal alu_src_b      : STD_LOGIC_VECTOR(31 downto 0);
    signal write_back_data: STD_LOGIC_VECTOR(31 downto 0);

begin

    -- =========================================================================
    -- 3. SIGN EXTENSION UNIT (Now a Component)
    -- =========================================================================
    SignExtend_Inst: SignExtend port map (
        Input  => imm,      -- Connect alias 'imm' (instr 15-0)
        Output => sign_imm  -- Connect to internal signal
    );

    -- =========================================================================
    -- 4. MULTIPLEXERS (The "Switching" Logic)
    -- =========================================================================
    
    -- Destination Register Mux (Controlled by RegDst)
    write_reg_addr <= rd;
    -- Future Phase 2: write_reg_addr <= rd when RegDst='1' else rt;

    -- ALU Operand B Mux (Controlled by ALUSrc)
    alu_src_b <= read_data_2;
    -- Future Phase 2: alu_src_b <= sign_imm when ALUSrc='1' else read_data_2;

    -- Write Back Mux (Controlled by MemToReg)
    write_back_data <= alu_result;
    -- Future Phase 2: write_back_data <= mem_data when MemToReg='1' else alu_result;


    -- =========================================================================
    -- 5. COMPONENT INSTANTIATION
    -- =========================================================================

    RegFile_Inst: RegisterFile port map (
        read_sel1  => rs,
        read_sel2  => rt,
        write_sel  => write_reg_addr,
        write_ena  => regwrite,
        clk        => clk,
        reset      => reset,
        write_data => write_back_data,
        data1      => read_data_1,
        data2      => read_data_2
    );

    ALU_Inst: aluproj port map (
        data1   => read_data_1,
        data2   => alu_src_b,
        aluop   => aluoperation,
        dataout => alu_result,
        zflag   => zero
    );

    -- Final Output
    aluout <= alu_result;

end Structural;