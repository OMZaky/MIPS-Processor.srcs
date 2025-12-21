library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port (
        ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
        Funct     : in  STD_LOGIC_VECTOR(5 downto 0);
        Operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALUControl;

architecture rtl of ALUControl is
begin
    process(ALUOp, Funct)
    begin
        case ALUOp is
            when "00" => 
                Operation <= "0010"; -- LW/SW/ADDI -> ADD
                
            when "01" => 
                Operation <= "0110"; -- BEQ -> SUB
                
            when "10" => -- R-Type
                case Funct is
                    when "100000" => Operation <= "0010"; -- add
                    when "100010" => Operation <= "0110"; -- sub
                    when "100100" => Operation <= "0000"; -- and
                    when "100101" => Operation <= "0001"; -- or
                    when "101010" => Operation <= "0111"; -- slt
                    when "100111" => Operation <= "1100"; -- nor
                    when others   => Operation <= "0010"; -- default
                end case;
                
            when others => 
                Operation <= "0010";
        end case;
    end process;
end rtl;