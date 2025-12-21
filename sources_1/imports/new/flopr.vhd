library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flopr is
generic (n : NATURAL := 32);

port(
clk, reset: in STD_LOGIC;
d: in STD_LOGIC_VECTOR(n-1 downto 0);
q: out STD_LOGIC_VECTOR(n-1 downto 0));

end Flopr;

architecture rtl of Flopr is

begin

    process(clk, reset)

    begin
    
    if reset='1' then
    q <= (others => '0');
    Elsif rising_edge(clk)
    then  q <= d;
    end if;
    end process;
    
end rtl;