library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity controller is
  port
  (
    op             : in std_logic_vector(6 downto 0);
    funct3         : in std_logic_vector(2 downto 0);
    funct7b5, Zero : in std_logic;
    ResultSrc      : out std_logic_vector(1 downto 0);
    MemWrite       : out std_logic;
    PCSrc, ALUSrc  : out std_logic;
    RegWrite       : out std_logic;
    Jump           : out std_logic;
    ImmSrc         : out std_logic_vector(1 downto 0);
    ALUControl     : out std_logic_vector(2 downto 0));
end;
architecture struct of controller is
  component maindec
    port
    (
      op             : in std_logic_vector(6 downto 0);
      ResultSrc      : out std_logic_vector(1 downto 0);
      MemWrite       : out std_logic;
      Branch, ALUSrc : out std_logic;
      RegWrite, Jump : out std_logic;
      ImmSrc         : out std_logic_vector(1 downto 0);
      ALUOp          : out std_logic_vector(1 downto 0));
  end component;
  component aludec
    port
    (
      opb5       : in std_logic;
      funct3     : in std_logic_vector(2 downto 0);
      funct7b5   : in std_logic;
      ALUOp      : in std_logic_vector(1 downto 0);
      ALUControl : out std_logic_vector(2 downto 0));
  end component;
  signal ALUOp  : std_logic_vector(1 downto 0);
  signal Branch : std_logic;
  signal Jump_w : std_logic;
begin
  md : maindec port map
  (
    op, ResultSrc, MemWrite, Branch,
    ALUSrc, RegWrite, Jump_w, ImmSrc, ALUOp);
  ad : aludec port
  map(op(5), funct3, funct7b5, ALUOp, ALUControl);
  PCSrc <= (Branch and Zero) or Jump_w;
  Jump <= Jump_w;
end;