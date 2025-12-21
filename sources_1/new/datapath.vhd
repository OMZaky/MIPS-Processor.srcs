

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MIPS_Package.all;


    entity datapath is
        port(
            clk, reset: in STD_LOGIC;
            readdata: in STD_LOGIC_VECTOR(31 downto 0);
            instr: in STD_LOGIC_VECTOR(31 downto 0);
            memtoreg, pcsrc,alusrc,regwrite, regdst: in STD_LOGIC;
            aluoperation: in STD_LOGIC_VECTOR(3 downto 0);
            zero: out STD_LOGIC;
            pc: buffer STD_LOGIC_VECTOR(31 downto 0);
            jump: in std_logic;
            aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0));
    end datapath;

architecture struct of datapath is


signal writereg: STD_LOGIC_VECTOR(4 downto 0);
signal pcjump, pcnext, pcnextbr, pcplus4,  pcbranch: STD_LOGIC_VECTOR(31 downto 0);
signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);
signal readdata1, readdata2 : STD_LOGIC_VECTOR(31 downto 0);

begin



 writereg <= instr(15 downto 11) when regdst = '1' else instr(20 downto 16);

 regfile: RegisterFile port map(
        read_sel1  => instr(25 downto 21),  
        read_sel2  => instr(20 downto 16),  
        write_sel  => writereg,             
        write_ena  => regwrite,             
        clk        => clk,
        write_data => result,               
        data1      => readdata1,            
        data2      => readdata2             
    );
    
 writedata <= readdata2;

 signext: SignExtend port map(
        Input  => instr(15 downto 0),
        Output => signimm
    );
    
    
 srcb <= signimm when alusrc = '1' else readdata2;
 srca <= readdata1;

 alu: aluproj port map(
    data1   => srca,       
    data2   => srcb,
    aluop   => aluoperation,
    dataout => aluout,
    zflag   => zero
 );
 
  pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";   
 
 pcreg: flopr generic map(32) port map(clk, reset, pcnext, pc);

 pcadd1: adder port map(pc, X"00000004", pcplus4);

 immsh: sl2 port map(signimm, signimmsh);

 pcadd2: adder port map(pcplus4, signimmsh, pcbranch);

 pcbrmux: mux2 port map(pcplus4, pcbranch,  pcsrc, pcnextbr);

 pcmux: mux2 port map(pcnextbr, pcjump, jump, pcnext);
    
 result <= readdata when memtoreg = '1' else aluout;



  end struct;
