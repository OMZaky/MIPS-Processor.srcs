library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
    Port ( 
        Input  : in  STD_LOGIC_VECTOR(15 downto 0); -- The 16-bit immediate
        Output : out STD_LOGIC_VECTOR(31 downto 0)  -- The 32-bit sign-extended result
    );
end SignExtend;

architecture rtl of SignExtend is
begin
    -- Replicate the sign bit (Input(15)) into the upper 16 bits
    Output <= (31 downto 16 => Input(15)) & Input;
end rtl;