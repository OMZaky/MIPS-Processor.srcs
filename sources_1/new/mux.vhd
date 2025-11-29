library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux is
  Port (I31, I30, I29, I28, I27, I26, I25, I24, I23, I22,
        I21, I20, I19, I18, I17, I16, I15, I14, I13, I12,
        I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 
        : in  STD_LOGIC_VECTOR(31 downto 0);
       
        S : in STD_LOGIC_VECTOR(4 downto 0);
        O : out STD_LOGIC_VECTOR(31 downto 0));

end Mux;

architecture rtl of Mux is

begin
   O <= I0  when S = "00000" else
        I1  when S = "00001" else
        I2  when S = "00010" else
        I3  when S = "00011" else
        I4  when S = "00100" else
        I5  when S = "00101" else
        I6  when S = "00110" else
        I7  when S = "00111" else
        I8  when S = "01000" else
        I9  when S = "01001" else
        I10 when S = "01010" else
        I11 when S = "01011" else
        I12 when S = "01100" else
        I13 when S = "01101" else
        I14 when S = "01110" else
        I15 when S = "01111" else
        I16 when S = "10000" else
        I17 when S = "10001" else
        I18 when S = "10010" else
        I19 when S = "10011" else
        I20 when S = "10100" else
        I21 when S = "10101" else
        I22 when S = "10110" else
        I23 when S = "10111" else
        I24 when S = "11000" else
        I25 when S = "11001" else
        I26 when S = "11010" else
        I27 when S = "11011" else
        I28 when S = "11100" else
        I29 when S = "11101" else
        I30 when S = "11110" else
        I31 when S = "11111" else
        (others => '0');


end rtl;
