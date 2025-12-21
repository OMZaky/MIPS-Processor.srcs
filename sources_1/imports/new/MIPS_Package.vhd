library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MIPS_Package is

    component aluproj
        Port ( 
            data1   : in  STD_LOGIC_VECTOR (31 downto 0);
            data2   : in  STD_LOGIC_VECTOR (31 downto 0);
            aluop   : in  STD_LOGIC_VECTOR (3 downto 0);
            dataout : out STD_LOGIC_VECTOR (31 downto 0);
            zflag   : out STD_LOGIC;
            nflag   : out STD_LOGIC 
        );
    end component;
	
    component dmem
        port(
            clk, we: in STD_LOGIC;
            a, wd: in STD_LOGIC_VECTOR (31 downto 0);
            rd: out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
	
    component imem
        port(
            a: in STD_LOGIC_VECTOR(5 downto 0);
            rd: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component alu_decoder
        Port (
            sel : in  STD_LOGIC_VECTOR(4 downto 0);
            y   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component mux
        Port (
            I31, I30, I29, I28, I27, I26, I25, I24, I23, I22,
            I21, I20, I19, I18, I17, I16, I15, I14, I13, I12,
            I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0 
            : in  STD_LOGIC_VECTOR(31 downto 0);
            S : in STD_LOGIC_VECTOR(4 downto 0);
            O : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component flopr generic (n : NATURAL := 32); 
        port(
            clk, reset: in STD_LOGIC;
            d: in STD_LOGIC_VECTOR(n-1 downto 0);
            q: out STD_LOGIC_VECTOR(n-1 downto 0)
        );
    end component;
  
    component RegisterFile
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
    end component;
    
    component SignExtend
        Port ( 
            Input  : in  STD_LOGIC_VECTOR(15 downto 0);
            Output : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component ALUControl
        Port (
            ALUOp     : in  STD_LOGIC_VECTOR(1 downto 0);
            Funct     : in  STD_LOGIC_VECTOR(5 downto 0);
            Operation : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component datapath
        port(
            clk, reset   : in STD_LOGIC;
            readdata     : in STD_LOGIC_VECTOR(31 downto 0);
            instr        : in STD_LOGIC_VECTOR(31 downto 0);
            memtoreg     : in STD_LOGIC_VECTOR(1 downto 0); 
            pcsrc        : in STD_LOGIC;
            alusrc       : in STD_LOGIC;
            regwrite     : in STD_LOGIC;
            regdst       : in STD_LOGIC_VECTOR(1 downto 0); 
            aluoperation : in STD_LOGIC_VECTOR(3 downto 0);
            jump         : in STD_LOGIC;
            jumpsrc      : in STD_LOGIC_VECTOR(1 downto 0); 
            regwrite2    : in STD_LOGIC;                    
            zero         : out STD_LOGIC;
            nflag        : out STD_LOGIC;                   
            pc           : out STD_LOGIC_VECTOR(31 downto 0);
            aluout       : out STD_LOGIC_VECTOR(31 downto 0);
            writedata    : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
        
    component Main_Control
        Port ( 
           OpCode   : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst   : out STD_LOGIC_VECTOR(1 downto 0);
           MemToReg : out STD_LOGIC_VECTOR(1 downto 0);
           JumpSrc  : out STD_LOGIC_VECTOR(1 downto 0);
           AluSrc   : out STD_LOGIC;
           Jump     : out STD_LOGIC;
           Branch   : out STD_LOGIC;
           BranchOp : out STD_LOGIC_VECTOR(2 downto 0);
           AluOp    : out STD_LOGIC_VECTOR (1 downto 0);
           MemRead  : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           RegWrite2: out STD_LOGIC
        );
    end component;
    
    component adder is
        Port ( 
            a : in STD_LOGIC_VECTOR (31 downto 0);
            b : in STD_LOGIC_VECTOR (31 downto 0);
            output : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
    
    component mux2 is generic (n : NATURAL := 32);
        Port ( 
            I1 : in STD_LOGIC_VECTOR (n-1 downto 0);
            I2 : in STD_LOGIC_VECTOR (n-1 downto 0);
            sel : in STD_LOGIC;
            output : out STD_LOGIC_VECTOR (n-1 downto 0)
        );
    end component;
    
    component sl2 is
        Port ( 
            a : in STD_LOGIC_VECTOR (31 downto 0);
            o : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

end MIPS_Package;