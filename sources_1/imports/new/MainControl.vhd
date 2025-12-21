library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_Control is
    Port ( 
        OpCode   : in  STD_LOGIC_VECTOR (5 downto 0);
        RegDst   : out STD_LOGIC;
        Jump     : out STD_LOGIC;
        Branch   : out STD_LOGIC;
        MemRead  : out STD_LOGIC;
        MemToReg : out STD_LOGIC;
        AluOp    : out STD_LOGIC_VECTOR (1 downto 0);
        MemWrite : out STD_LOGIC;
        AluSrc   : out STD_LOGIC;
        RegWrite : out STD_LOGIC
    );
end Main_Control;

architecture Behavioral of Main_Control is
begin
    process(OpCode)
    begin
        -- Initialize defaults to avoid latches
        RegDst   <= '0';
        Jump     <= '0';
        Branch   <= '0';
        MemRead  <= '0';
        MemToReg <= '0';
        AluOp    <= "00";
        MemWrite <= '0';
        AluSrc   <= '0';
        RegWrite <= '0';

        case OpCode is
            -- R-Type (add, sub, and, or, slt)
            when "000000" => 
                RegDst   <= '1';
                RegWrite <= '1';
                AluOp    <= "10";

            -- lw (load word)
            when "100011" => 
                AluSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                AluOp    <= "00";

            -- sw (store word)
            when "101011" => 
                AluSrc   <= '1';
                MemWrite <= '1';
                AluOp    <= "00";

            -- beq (branch if equal)
            when "000100" => 
                Branch   <= '1';
                AluOp    <= "01";

            -- addi (add immediate)
            when "001000" => 
                AluSrc   <= '1';
                RegWrite <= '1';
                AluOp    <= "00";

            -- j (jump) -> CRITICAL FOR YOUR TEST
            when "000010" => 
                Jump     <= '1';

            when others =>
                -- Keep defaults
        end case;
    end process;
end Behavioral;