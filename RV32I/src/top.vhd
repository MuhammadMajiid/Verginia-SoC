library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity top is
  port
  (
    clk, reset         : in std_logic;
    WriteData, DataAdr : buffer std_logic_vector(31 downto 0);
    MemWrite           : buffer std_logic);
end;
architecture test of top is
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
begin
  -- instantiate processor and memories
  rvsingle : rv32i port map
  (
    clk, reset, PC, Instr,
    MemWrite, DataAdr,
    WriteData, ReadData);
  imem1 : imem port
  map(PC, Instr);
  dmem1 : dmem port
  map(clk, MemWrite, DataAdr, WriteData,
  ReadData);
end;