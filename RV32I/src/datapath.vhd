library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity datapath is
  port
  (
    clk           : in std_logic;
    reset         : in std_logic; -- Active Low
    ResultSrc            : in std_logic_vector(1 downto 0);
    PCSrc, ALUSrc        : in std_logic;
    RegWrite             : in std_logic;
    ImmSrc               : in std_logic_vector(1 downto 0);
    ALUControl           : in std_logic_vector(2 downto 0);
    Zero                 : out std_logic;
    PC                   : out std_logic_vector(31 downto 0);
    Instr                : in std_logic_vector(31 downto 0);
    ALUResult, WriteData : out std_logic_vector(31 downto 0);
    ReadData             : in std_logic_vector(31 downto 0));
end;
architecture struct of datapath is
  component flopr generic
    (width : integer);
    port
    (
      clk, reset : in std_logic;
      d          : in std_logic_vector(width-1 downto 0);
      q          : out std_logic_vector(width-1 downto 0));
  end component;
  component adder
    port
    (
      a, b : in std_logic_vector(31 downto 0);
      y    : out std_logic_vector(31 downto 0));
  end component;
  component mux2 generic
    (width : integer);
    port
    (
      d0, d1 : in std_logic_vector(width-1 downto 0);
      s      : in std_logic;
      y      : out std_logic_vector(width-1 downto 0));
  end component;
  component mux3 generic
    (width : integer);
    port
    (
      d0, d1, d2 : in std_logic_vector(width-1 downto 0);
      s          : in std_logic_vector(1 downto 0);
      y          : out std_logic_vector(width-1 downto 0));
  end component;
  component regfile
    port
    (
      clk        : in std_logic;
      we3        : in std_logic;
      a1, a2, a3 : in std_logic_vector(4 downto 0);
      wd3        : in std_logic_vector(31 downto 0);
      rd1, rd2   : out std_logic_vector(31 downto 0));
  end component;
  component extend
    port
    (
      instr  : in std_logic_vector(31 downto 7);
      immsrc : in std_logic_vector(1 downto 0);
      immext : out std_logic_vector(31 downto 0));
  end component;
  component alu
    port
    (
      a, b       : in std_logic_vector(31 downto 0);
      ALUControl : in std_logic_vector(2 downto 0);
      ALUResult  : out std_logic_vector(31 downto 0);
      Zero       : out std_logic);
  end component;
  signal PCNext, PCPlus4, PCTarget : std_logic_vector(31 downto 0);
  signal ImmExt                    : std_logic_vector(31 downto 0);
  signal SrcA, SrcB                : std_logic_vector(31 downto 0);
  signal Result                    : std_logic_vector(31 downto 0);
  signal ALUResult_W                    : std_logic_vector(31 downto 0);
  signal WriteData_W                    : std_logic_vector(31 downto 0);
  signal PC_W                    : std_logic_vector(31 downto 0);

begin
  -- next PC logic
  PC <= PC_W; 
  pcreg : flopr generic
  map(32) port map
  (clk, reset, PCNext, PC_W);
  pcadd4 : adder port
  map(PC_W, X"00000004", PCPlus4);
  pcaddbranch : adder port
  map(PC_W, ImmExt, PCTarget);
  pcmux : mux2 generic
  map(32) port
  map(PCPlus4, PCTarget, PCSrc,
  PCNext);
  -- register file logic
  rf : regfile port
  map(clk, RegWrite, Instr(19 downto 15),
  Instr(24 downto 20), Instr(11 downto 7),
  Result, SrcA, WriteData_W);
  WriteData <= WriteData_W;
  ext : extend port
  map(Instr(31 downto 7), ImmSrc, ImmExt);
  -- ALU logic
  srcbmux : mux2 generic
  map(32) port
  map(WriteData_W, ImmExt,
  ALUSrc, SrcB);
  mainalu : alu port
  map(SrcA, SrcB, ALUControl, ALUResult_W, Zero);
  ALUResult <= ALUResult_W;
  resultmux : mux3 generic
  map(32) port
  map(ALUResult_W, ReadData,
  PCPlus4, ResultSrc,
  Result);
end;