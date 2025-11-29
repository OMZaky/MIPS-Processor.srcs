library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port (
        ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0); -- From Main Control
        Funct     : in  STD_LOGIC_VECTOR(5 downto 0); -- Instruction [5-0]
        Operation : out STD_LOGIC_VECTOR(3 downto 0)  -- To ALU
    );
end ALUControl;

architecture rtl of ALUControl is
begin
    process(ALUOp, Funct)
    begin
        case ALUOp is
            -- ALUOp = 00: LW/SW (Always ADD)
            when "00" => 
                Operation <= "0010"; 
            
            -- ALUOp = 01: BEQ (Always SUB)
            when "01" => 
                Operation <= "0110"; 
            
            -- ALUOp = 10: R-Type (Look at Funct field)
            when "10" => 
                case Funct is
                    when "100000" => Operation <= "0010"; -- ADD (0x20)
                    when "100010" => Operation <= "0110"; -- SUB (0x22)
                    when "100100" => Operation <= "0000"; -- AND (0x24)
                    when "100101" => Operation <= "0001"; -- OR  (0x25)
                    when "101010" => Operation <= "0111"; -- SLT (0x2A)
                    when "100111" => Operation <= "1100"; -- NOR (0x27)
                    when others   => Operation <= "0000"; -- Default
                end case;
                
            when others => 
                Operation <= "0000"; -- Default
        end case;
    end process;
end rtl;