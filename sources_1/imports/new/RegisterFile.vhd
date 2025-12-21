library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MIPS_Package.all;

entity RegisterFile is
    Port ( 
        read_sel1 : in  STD_LOGIC_VECTOR(4 downto 0);
        read_sel2 : in  STD_LOGIC_VECTOR(4 downto 0);
        
        write_sel : in  STD_LOGIC_VECTOR(4 downto 0);
        write_ena : in  STD_LOGIC;
        write_data: in  STD_LOGIC_VECTOR(31 downto 0);
        
        write_sel2 : in  STD_LOGIC_VECTOR(4 downto 0);
        write_ena2 : in  STD_LOGIC;
        write_data2: in  STD_LOGIC_VECTOR(31 downto 0);
        
        clk       : in  STD_LOGIC;
        data1     : out STD_LOGIC_VECTOR(31 downto 0);
        data2     : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegisterFile;

architecture rtl of RegisterFile is

    signal reset : std_logic := '0';
    
    signal dec_out1 : STD_LOGIC_VECTOR(31 downto 0);
    signal dec_out2 : STD_LOGIC_VECTOR(31 downto 0);
    
    signal load1    : STD_LOGIC_VECTOR(31 downto 0);
    signal load2    : STD_LOGIC_VECTOR(31 downto 0);
    
    signal q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : STD_LOGIC_VECTOR(31 downto 0);
    signal q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31 : STD_LOGIC_VECTOR(31 downto 0);
    
    signal d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15 : STD_LOGIC_VECTOR(31 downto 0);
    signal d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31 : STD_LOGIC_VECTOR(31 downto 0);

begin

    Dec1_Inst : alu_decoder port map (sel => write_sel,  y => dec_out1);
    Dec2_Inst : alu_decoder port map (sel => write_sel2, y => dec_out2);

    
    GEN_LOAD: for i in 1 to 31 generate
        load1(i) <= write_ena  AND dec_out1(i);
        load2(i) <= write_ena2 AND dec_out2(i);
    end generate;

   
    q0 <= (others => '0'); 

    -- REGISTER 1
    d1 <= write_data when load1(1) = '1' else write_data2 when load2(1) = '1' else q1;
    REG_1: flopr generic map(32) port map(clk => clk, reset => reset, d => d1, q => q1);

    -- REGISTER 2
    d2 <= write_data when load1(2) = '1' else write_data2 when load2(2) = '1' else q2;
    REG_2: flopr generic map(32) port map(clk => clk, reset => reset, d => d2, q => q2);

    -- REGISTER 3
    d3 <= write_data when load1(3) = '1' else write_data2 when load2(3) = '1' else q3;
    REG_3: flopr generic map(32) port map(clk => clk, reset => reset, d => d3, q => q3);

    -- REGISTER 4
    d4 <= write_data when load1(4) = '1' else write_data2 when load2(4) = '1' else q4;
    REG_4: flopr generic map(32) port map(clk => clk, reset => reset, d => d4, q => q4);

    -- REGISTER 5
    d5 <= write_data when load1(5) = '1' else write_data2 when load2(5) = '1' else q5;
    REG_5: flopr generic map(32) port map(clk => clk, reset => reset, d => d5, q => q5);

    -- REGISTER 6
    d6 <= write_data when load1(6) = '1' else write_data2 when load2(6) = '1' else q6;
    REG_6: flopr generic map(32) port map(clk => clk, reset => reset, d => d6, q => q6);

    -- REGISTER 7
    d7 <= write_data when load1(7) = '1' else write_data2 when load2(7) = '1' else q7;
    REG_7: flopr generic map(32) port map(clk => clk, reset => reset, d => d7, q => q7);

    -- REGISTER 8
    d8 <= write_data when load1(8) = '1' else write_data2 when load2(8) = '1' else q8;
    REG_8: flopr generic map(32) port map(clk => clk, reset => reset, d => d8, q => q8);

    -- REGISTER 9
    d9 <= write_data when load1(9) = '1' else write_data2 when load2(9) = '1' else q9;
    REG_9: flopr generic map(32) port map(clk => clk, reset => reset, d => d9, q => q9);

    -- REGISTER 10
    d10 <= write_data when load1(10) = '1' else write_data2 when load2(10) = '1' else q10;
    REG_10: flopr generic map(32) port map(clk => clk, reset => reset, d => d10, q => q10);

    -- REGISTER 11
    d11 <= write_data when load1(11) = '1' else write_data2 when load2(11) = '1' else q11;
    REG_11: flopr generic map(32) port map(clk => clk, reset => reset, d => d11, q => q11);

    -- REGISTER 12
    d12 <= write_data when load1(12) = '1' else write_data2 when load2(12) = '1' else q12;
    REG_12: flopr generic map(32) port map(clk => clk, reset => reset, d => d12, q => q12);

    -- REGISTER 13
    d13 <= write_data when load1(13) = '1' else write_data2 when load2(13) = '1' else q13;
    REG_13: flopr generic map(32) port map(clk => clk, reset => reset, d => d13, q => q13);

    -- REGISTER 14
    d14 <= write_data when load1(14) = '1' else write_data2 when load2(14) = '1' else q14;
    REG_14: flopr generic map(32) port map(clk => clk, reset => reset, d => d14, q => q14);

    -- REGISTER 15
    d15 <= write_data when load1(15) = '1' else write_data2 when load2(15) = '1' else q15;
    REG_15: flopr generic map(32) port map(clk => clk, reset => reset, d => d15, q => q15);

    -- REGISTER 16
    d16 <= write_data when load1(16) = '1' else write_data2 when load2(16) = '1' else q16;
    REG_16: flopr generic map(32) port map(clk => clk, reset => reset, d => d16, q => q16);

    -- REGISTER 17
    d17 <= write_data when load1(17) = '1' else write_data2 when load2(17) = '1' else q17;
    REG_17: flopr generic map(32) port map(clk => clk, reset => reset, d => d17, q => q17);

    -- REGISTER 18
    d18 <= write_data when load1(18) = '1' else write_data2 when load2(18) = '1' else q18;
    REG_18: flopr generic map(32) port map(clk => clk, reset => reset, d => d18, q => q18);

    -- REGISTER 19
    d19 <= write_data when load1(19) = '1' else write_data2 when load2(19) = '1' else q19;
    REG_19: flopr generic map(32) port map(clk => clk, reset => reset, d => d19, q => q19);

    -- REGISTER 20
    d20 <= write_data when load1(20) = '1' else write_data2 when load2(20) = '1' else q20;
    REG_20: flopr generic map(32) port map(clk => clk, reset => reset, d => d20, q => q20);

    -- REGISTER 21
    d21 <= write_data when load1(21) = '1' else write_data2 when load2(21) = '1' else q21;
    REG_21: flopr generic map(32) port map(clk => clk, reset => reset, d => d21, q => q21);

    -- REGISTER 22
    d22 <= write_data when load1(22) = '1' else write_data2 when load2(22) = '1' else q22;
    REG_22: flopr generic map(32) port map(clk => clk, reset => reset, d => d22, q => q22);

    -- REGISTER 23
    d23 <= write_data when load1(23) = '1' else write_data2 when load2(23) = '1' else q23;
    REG_23: flopr generic map(32) port map(clk => clk, reset => reset, d => d23, q => q23);

    -- REGISTER 24
    d24 <= write_data when load1(24) = '1' else write_data2 when load2(24) = '1' else q24;
    REG_24: flopr generic map(32) port map(clk => clk, reset => reset, d => d24, q => q24);

    -- REGISTER 25
    d25 <= write_data when load1(25) = '1' else write_data2 when load2(25) = '1' else q25;
    REG_25: flopr generic map(32) port map(clk => clk, reset => reset, d => d25, q => q25);

    -- REGISTER 26
    d26 <= write_data when load1(26) = '1' else write_data2 when load2(26) = '1' else q26;
    REG_26: flopr generic map(32) port map(clk => clk, reset => reset, d => d26, q => q26);

    -- REGISTER 27
    d27 <= write_data when load1(27) = '1' else write_data2 when load2(27) = '1' else q27;
    REG_27: flopr generic map(32) port map(clk => clk, reset => reset, d => d27, q => q27);

    -- REGISTER 28
    d28 <= write_data when load1(28) = '1' else write_data2 when load2(28) = '1' else q28;
    REG_28: flopr generic map(32) port map(clk => clk, reset => reset, d => d28, q => q28);

    -- REGISTER 29
    d29 <= write_data when load1(29) = '1' else write_data2 when load2(29) = '1' else q29;
    REG_29: flopr generic map(32) port map(clk => clk, reset => reset, d => d29, q => q29);

    -- REGISTER 30
    d30 <= write_data when load1(30) = '1' else write_data2 when load2(30) = '1' else q30;
    REG_30: flopr generic map(32) port map(clk => clk, reset => reset, d => d30, q => q30);

    -- REGISTER 31
    d31 <= write_data when load1(31) = '1' else write_data2 when load2(31) = '1' else q31;
    REG_31: flopr generic map(32) port map(clk => clk, reset => reset, d => d31, q => q31);

    
    
    -- Mux for Read Port 1
    ReadMux1: mux port map (
        I0 => q0, I1 => q1, I2 => q2, I3 => q3, I4 => q4, I5 => q5, I6 => q6, I7 => q7,
        I8 => q8, I9 => q9, I10 => q10, I11 => q11, I12 => q12, I13 => q13, I14 => q14, I15 => q15,
        I16 => q16, I17 => q17, I18 => q18, I19 => q19, I20 => q20, I21 => q21, I22 => q22, I23 => q23,
        I24 => q24, I25 => q25, I26 => q26, I27 => q27, I28 => q28, I29 => q29, I30 => q30, I31 => q31,
        S => read_sel1,
        O => data1
    );

    -- Mux for Read Port 2
    ReadMux2: mux port map (
        I0 => q0, I1 => q1, I2 => q2, I3 => q3, I4 => q4, I5 => q5, I6 => q6, I7 => q7,
        I8 => q8, I9 => q9, I10 => q10, I11 => q11, I12 => q12, I13 => q13, I14 => q14, I15 => q15,
        I16 => q16, I17 => q17, I18 => q18, I19 => q19, I20 => q20, I21 => q21, I22 => q22, I23 => q23,
        I24 => q24, I25 => q25, I26 => q26, I27 => q27, I28 => q28, I29 => q29, I30 => q30, I31 => q31,
        S => read_sel2,
        O => data2
    );

end rtl;