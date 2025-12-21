library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_decoder is
    port(
        sel : in std_logic_vector(4 downto 0);
        y   : out std_logic_vector(31 downto 0)
    );
end alu_decoder;

architecture rtl of alu_decoder is
begin
    process(sel)
    begin
        -- Initialize to all zeros to prevent latches
        y <= (others => '0');
        
        case sel is
            when "00000" => y(0)  <= '1';
            when "00001" => y(1)  <= '1';
            when "00010" => y(2)  <= '1';
            when "00011" => y(3)  <= '1';
            when "00100" => y(4)  <= '1';
            when "00101" => y(5)  <= '1';
            when "00110" => y(6)  <= '1';
            when "00111" => y(7)  <= '1';
            when "01000" => y(8)  <= '1';
            when "01001" => y(9)  <= '1';
            when "01010" => y(10) <= '1';
            when "01011" => y(11) <= '1';
            when "01100" => y(12) <= '1';
            when "01101" => y(13) <= '1';
            when "01110" => y(14) <= '1';
            when "01111" => y(15) <= '1';
            when "10000" => y(16) <= '1';
            when "10001" => y(17) <= '1';
            when "10010" => y(18) <= '1';
            when "10011" => y(19) <= '1';
            when "10100" => y(20) <= '1';
            when "10101" => y(21) <= '1';
            when "10110" => y(22) <= '1';
            when "10111" => y(23) <= '1';
            when "11000" => y(24) <= '1';
            when "11001" => y(25) <= '1';
            when "11010" => y(26) <= '1';
            when "11011" => y(27) <= '1';
            when "11100" => y(28) <= '1';
            when "11101" => y(29) <= '1';
            when "11110" => y(30) <= '1';
            when "11111" => y(31) <= '1';
            when others  => y     <= (others => '0');
        end case;
    end process;
end rtl;