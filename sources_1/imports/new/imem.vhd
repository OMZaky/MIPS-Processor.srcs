library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;
library STD;
use STD.textio.all;

entity imem is -- instruction memory
    port(
        a: in STD_LOGIC_VECTOR(5 downto 0);
        rd: out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture behave of imem is
begin
    process is
        file mem_file: TEXT;
        variable L: line;
        variable ch: character;
        variable i, index, result: integer;
        type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
        variable mem: ramtype;
        variable status : file_open_status; -- Added to check if file opens successfully
    begin
        -- initialize memory from file
        for i in 0 to 63 loop -- set all contents low
            mem(i) := (others => '0');
        end loop;
        index := 0;
        
        -- CHANGE 1: Use relative path "memfile.dat" instead of "E:/memfile.dat"
        file_open(status, mem_file, "memfile.dat", read_mode);
        
        -- CHANGE 2: Check if file opened successfully
        if status /= open_ok then
            report "CRITICAL ERROR: Could not open 'memfile.dat'. Please ensure this file is in your simulation folder (e.g., .../project_name.sim/sim_1/behav/xsim/)" severity failure;
        end if;

        while not endfile(mem_file) loop
            readline(mem_file, L);
            result := 0;
            for i in 1 to 8 loop
                read (L, ch);
                if '0' <= ch and ch <= '9' then
                    result := character'pos(ch) - character'pos('0');
                elsif 'a' <= ch and ch <= 'f' then
                    result := character'pos(ch) - character'pos('a')+10;
                else 
                    report "Format error on line " & integer'image(index) severity error;
                end if;
                mem(index)(35-i*4 downto 32-i*4) := std_logic_vector(to_unsigned(result,4));
            end loop;
            index := index + 1;
        end loop;
        file_close(mem_file);

        -- read memory
        loop
            rd <= mem(CONV_INTEGER(a));
            wait on a;
        end loop;
    end process;
end;