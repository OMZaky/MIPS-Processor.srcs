

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux2 is generic (n : NATURAL := 32);
    Port ( I1 : in STD_LOGIC_VECTOR (n-1 downto 0);
           I2 : in STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (n-1 downto 0));
end mux2;

architecture Behavioral of mux2 is

begin
output <= I1 when sel='0' else I2;

end Behavioral;
