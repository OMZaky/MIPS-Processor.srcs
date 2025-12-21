----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2025 01:05:01 AM
-- Design Name: 
-- Module Name: mux2 - Behavioral
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
