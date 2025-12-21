library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_Control is
    Port ( 
        OpCode   : in  STD_LOGIC_VECTOR (5 downto 0);
        RegDst   : out STD_LOGIC_VECTOR(1 downto 0); 
        MemToReg : out STD_LOGIC_VECTOR(1 downto 0); 
        JumpSrc  : out STD_LOGIC_VECTOR(1 downto 0); -- 2-bit Vector
        AluSrc   : out STD_LOGIC;                    
        Jump     : out STD_LOGIC;
        Branch   : out STD_LOGIC;                    
        BranchOp : out STD_LOGIC_VECTOR(2 downto 0); 
        AluOp    : out STD_LOGIC_VECTOR(1 downto 0);
        MemRead  : out STD_LOGIC;
        MemWrite : out STD_LOGIC;
        RegWrite : out STD_LOGIC;
        RegWrite2: out STD_LOGIC                     
    );
end Main_Control;

architecture Behavioral of Main_Control is
begin
    process(OpCode)
    begin
        RegDst   <= "00";   
        MemToReg <= "00";   
        Jump     <= '0';
        JumpSrc  <= "00";   
        Branch   <= '0';
        BranchOp <= "000";  
        MemRead  <= '0';
        MemWrite <= '0';
        RegWrite <= '0';
        RegWrite2<= '0';
        AluSrc   <= '0';    
        AluOp    <= "00";   

        case OpCode is
            when "000000" => -- R
                RegDst   <= "01"; RegWrite <= '1'; AluOp <= "10";
            when "100011" => -- lw
                AluSrc <= '1'; MemToReg <= "01"; RegWrite <= '1'; MemRead <= '1'; AluOp <= "00";
            when "101011" => -- sw
                AluSrc <= '1'; MemWrite <= '1'; AluOp <= "00";
            when "001000" => -- addi
                AluSrc <= '1'; RegWrite <= '1'; AluOp <= "00";
            when "000100" => -- beq
                Branch <= '1'; BranchOp <= "000"; AluOp <= "01";
            when "000101" => -- bne
                Branch <= '1'; BranchOp <= "001"; AluOp <= "01";
            when "000001" => -- blt
                Branch <= '1'; BranchOp <= "010"; AluOp <= "01";
            when "000010" => -- j
                Jump <= '1'; JumpSrc <= "00";
            when "000011" => -- jal
                Jump <= '1'; JumpSrc <= "00"; RegWrite <= '1'; RegDst <= "10"; MemToReg <= "10";
            when "010010" => -- jalr (Custom 18)
                Jump <= '1'; JumpSrc <= "01"; RegWrite <= '1'; RegDst <= "10"; MemToReg <= "10";
            when "010011" => -- jr (Custom 19)
                Jump <= '1'; JumpSrc <= "01"; RegWrite <= '0';
            when "010000" => -- lwr
                RegDst <= "01"; MemToReg <= "01"; RegWrite <= '1'; MemRead <= '1'; AluOp <= "00";
            when "010001" => -- lw_incr
                AluSrc <= '1'; MemToReg <= "01"; RegWrite <= '1'; MemRead <= '1'; RegWrite2 <= '1'; AluOp <= "00";
            when others => null;
        end case;
    end process;
end Behavioral;