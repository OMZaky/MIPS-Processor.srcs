library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainControl is
    Port ( OpCode : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out STD_LOGIC;
           Jump : out STD_LOGIC;
           Branch : out STD_LOGIC;
           MemRead : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           AluOp : out std_logic_vector (1 downto 0);
           MemWrite : out STD_LOGIC;
           AluSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end MainControl;

architecture Behavioral of MainControl is

begin
       RegDst <= '1' when OpCode = "000000" else '0';
       Jump <= '1' when OpCode = "000010" else '0';
       Branch <= '1' when OpCode = "000100" else '0';
       MemRead <= '1' when OpCode = "100011" else '0';
       MemtoReg <= '1' when Opcode = "100011" else '0';
       AluOp <= "10" when OpCode = "000000" else 
                "01" when OpCode = "000100" else "00";
       MemWrite <= '1' when OpCode = "101011" else '0';
       AluSrc <= '1' when OpCode = ("100011" or "101011") else '0'; 
       RegWrite <= '1' when OpCode = ("000000" or "100011") else '0';
       
end Behavioral;
