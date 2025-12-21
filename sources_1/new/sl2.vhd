library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sl2 is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           o : out STD_LOGIC_VECTOR (31 downto 0));
end sl2;

architecture Behavioral of sl2 is

begin
o <= a(29 downto 0) & "00";

end Behavioral;
