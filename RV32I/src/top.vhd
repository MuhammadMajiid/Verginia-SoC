library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity top is
  port
  (
    clk           : in std_logic;
    reset         : in std_logic; -- Active Low
--    WriteData, DataAdr : out std_logic_vector(31 downto 0);
    MemWrite           : out std_logic
);
end top;
architecture structure of top is
  component rv32i
    port
    (
      clk, reset           : in std_logic;
      PC                   : out std_logic_vector(31 downto 0);
      Instr                : in std_logic_vector(31 downto 0);
      MemWrite             : out std_logic;
      ALUResult, WriteData : out std_logic_vector(31 downto 0);
      ReadData             : in std_logic_vector(31 downto 0));
  end component;
  component imem
    port
    (
      a  : in std_logic_vector(31 downto 0);
      rd : out std_logic_vector(31 downto 0));
  end component;
  component dmem
    port
    (
      clk, we : in std_logic;
      a, wd   : in std_logic_vector(31 downto 0);
      rd      : out std_logic_vector(31 downto 0));
  end component;
  signal PC, Instr, ReadData : std_logic_vector(31 downto 0);
  signal WriteData_W, DataAdr_W : std_logic_vector(31 downto 0);
  signal MemWrite_W          : std_logic;
begin
  -- instantiate processor and memories
  rvsingle : rv32i port map
  (
    clk, reset, PC, Instr,
    MemWrite_W, DataAdr_W,
    WriteData_W, ReadData);
  imem1 : imem port
  map(PC, Instr);
  dmem1 : dmem port
  map(clk, MemWrite_W, DataAdr_W, WriteData_W,
  ReadData);
--  WriteData <= WriteData_W;
--  DataAdr   <= DataAdr_W;
  MemWrite  <= MemWrite_W;
end structure;