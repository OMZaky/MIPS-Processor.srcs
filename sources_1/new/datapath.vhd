----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2025 12:49:26 AM
-- Design Name: 
-- Module Name: datapath - struct
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

entity datapath is
port(clk, reset: in STD_LOGIC;
readdata: in STD_LOGIC_VECTOR(31 downto 0);  instr: in STD_LOGIC_VECTOR(31 downto 0);  memtoreg, pcsrc,alusrc,regwrite, regdst: in STD_LOGIC;  aluoperation: in STD_LOGIC_VECTOR(2 downto 0);  zero: out STD_LOGIC;
pc: buffer STD_LOGIC_VECTOR(31 downto 0);
jump: in std_logic;
aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0));
end datapath;

architecture struct of datapath is
component flopr generic (n : NATURAL := 32); port(
clk, reset: in STD_LOGIC;
d: in STD_LOGIC_VECTOR(n-1 downto 0);
q: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;
component adder Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component sl2 Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           o : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component mux2 Port ( I1 : in STD_LOGIC_VECTOR (31 downto 0);
           I2 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
           end component;
signal writereg: STD_LOGIC_VECTOR(4 downto 0);
signal pcjump, pcnext, pcnextbr, pcplus4,  pcbranch: STD_LOGIC_VECTOR(31 downto 0);
signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);

begin
pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";
pcreg: flopr generic map(32) port map(clk, reset, pcnext, pc);
pcadd1: adder port map(pc, X"00000004", pcplus4);
immsh: sl2 port map(signimm, signimmsh);
pcadd2: adder port map(pcplus4, signimmsh, pcbranch);
pcbrmux: mux2 port map(pcplus4, pcbranch,  pcsrc, pcnextbr);
pcmux: mux2 port map(pcnextbr, pcjump, jump, pcnext);


end struct;
