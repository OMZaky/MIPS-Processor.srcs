library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MIPS_Package is

    -------------------------------------------------------------------------
    -- 1. ALU Component (aluproj)
    -------------------------------------------------------------------------
    component aluproj
        Port ( 
            data1   : in  STD_LOGIC_VECTOR (31 downto 0);
            data2   : in  STD_LOGIC_VECTOR (31 downto 0);
            aluop   : in  STD_LOGIC_VECTOR (3 downto 0);
            dataout : out STD_LOGIC_VECTOR (31 downto 0);
            zflag   : out STD_LOGIC
        );
    end component;

    -------------------------------------------------------------------------
    -- 2. Decoder Component (5-to-32)
    -------------------------------------------------------------------------
    component Decoder
        Port (
            sel : in  STD_LOGIC_VECTOR(4 downto 0);
            y   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -------------------------------------------------------------------------
    -- 3. Multiplexer Component (2-to-1, 32-bit)
    -------------------------------------------------------------------------
    component mux
        Port (I31, I30, I29, I28, I27, I26, I25, I24, I23, I22,
        I21, I20, I19, I18, I17, I16, I15, I14, I13, I12,
        I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 
        : in  STD_LOGIC_VECTOR(31 downto 0);
       
        S : in STD_LOGIC_VECTOR(4 downto 0);
        O : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    -------------------------------------------------------------------------
    -- 4. Flip-Flop Component (flopr)
    -------------------------------------------------------------------------
    component flopr
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            d     : in  STD_LOGIC_VECTOR(31 downto 0);
            q     : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -------------------------------------------------------------------------
    -- 5. Register File Component
    -------------------------------------------------------------------------
    component RegisterFile
        Port ( 
            read_sel1 : in  STD_LOGIC_VECTOR(4 downto 0);
            read_sel2 : in  STD_LOGIC_VECTOR(4 downto 0);
            write_sel : in  STD_LOGIC_VECTOR(4 downto 0);
            write_ena : in  STD_LOGIC;
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            write_data: in  STD_LOGIC_VECTOR(31 downto 0);
            data1     : out STD_LOGIC_VECTOR(31 downto 0);
            data2     : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

end MIPS_Package;