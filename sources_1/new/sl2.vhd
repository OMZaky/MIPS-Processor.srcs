----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2025 01:05:01 AM
-- Design Name: 
-- Module Name: sl2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sl2 is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           o : out STD_LOGIC_VECTOR (31 downto 0));
end sl2;

architecture Behavioral of sl2 is

begin
o <= a(29 downto 0) & "00";

end Behavioral;
