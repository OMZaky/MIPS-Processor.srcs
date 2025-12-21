library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity aluproj is
    Port ( data1 : in STD_LOGIC_VECTOR (31 downto 0);
           data2 : in STD_LOGIC_VECTOR (31 downto 0);
           aluop : in STD_LOGIC_VECTOR (3 downto 0);    
           dataout : out STD_LOGIC_VECTOR (31 downto 0);
           zflag : out STD_LOGIC);
end aluproj;

architecture rtl of aluproj is
    signal Sum, signeddata2, result: STD_LOGIC_VECTOR(31 downto 0);
    signal is_sub : std_logic;
begin

    is_sub <= '1' when aluop(3 downto 1) = "011" else '0';

    signeddata2 <= (not data2) when is_sub = '1' else data2;

    
    sum <= data1 + signeddata2 + is_sub; 

    result <= data1 and signeddata2 when aluop = "0000" else
              data1 or signeddata2  when aluop = "0001" else
              not(data1 or signeddata2) when aluop = "1100" else
              sum when aluop(1 downto 0) = "10" else
              (x"0000000" & "000" & sum(31)) when aluop(1 downto 0) = "11"
              else x"00000000";

    dataout <= result;
    zflag <= '1' when result = x"00000000" else '0';

end rtl;