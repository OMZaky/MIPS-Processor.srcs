library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity imem is
    port(
        a: in STD_LOGIC_VECTOR(5 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture dummy of imem is
begin
    -- No code here, just zeros
    rd <= (others => '0');
end;