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
            -- Case 00: Address Calculation & Immediate Math
            when "00" => 
                Operation <= "0010"; -- LW, SW, ADDI, LWR, LW_INCR -> Force ADD
                
            -- Case 01: Branch Comparisons
            when "01" => 
                Operation <= "0110"; -- BEQ, BNE, BLT, BGT, BLE -> Force SUB
                -- (The Main Module uses the resulting Zero/Negative flags)
                
            -- Case 10: R-Type Instructions (Look at Funct)
            when "10" => 
                case Funct is
                    when "100000" => Operation <= "0010"; -- add
                    when "100010" => Operation <= "0110"; -- sub
                    when "100100" => Operation <= "0000"; -- and
                    when "100101" => Operation <= "0001"; -- or
                    when "101010" => Operation <= "0111"; -- slt
                    when "100111" => Operation <= "1100"; -- nor
                    
                    -- Note: 'jr' (001000) and 'jalr' (001001) fall to default.
                    -- This effectively performs an ADD, which is fine because 
                    -- the ALU result is ignored for Jump Register instructions.
                    when others   => Operation <= "0010"; -- default (ADD)
                end case;
                
            when others => 
                Operation <= "0010";
        end case;
    end process;
end rtl;