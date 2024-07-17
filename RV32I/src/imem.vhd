library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.all;
use ieee.std_logic_textio.all;
entity imem is
  port
  (
    a  : in std_logic_vector(31 downto 0);
    rd : out std_logic_vector(31 downto 0));
end entity;

-- architecture behave of imem is
--   type ramtype is array(63 downto 0) of
--   std_logic_vector(31 downto 0);
--   -- initialize memory from file
--   impure function init_ram_hex return ramtype is
--     file text_file       : text open read_mode is "riscvtest.txt";
--     -- It checks for memory writes and reports success if the correct value (25) is written to address 100. 
--     variable text_line   : line;
--     variable ram_content : ramtype;
--     variable i           : integer := 0;
--   begin
--     for i in 0 to 63 loop -- set all contents low
--       ram_content(i) := (others => '0');
--     end loop;
--     while not endfile(text_file) loop -- set contents from file
--       readline(text_file, text_line);
--       hread(text_line, ram_content(i));
--       i := i + 1;
--     end loop;
--     return ram_content;
--   end function;
--   signal mem : ramtype := init_ram_hex;
-- begin
--   -- read memory
--   process (a) begin
--     rd <= mem(to_integer(unsigned(a(31 downto 2))));
--   end process;
-- end;


architecture behave of imem is
  -- ROM declaration
  type ramtype is array (0 to 64) of std_logic_vector (31 downto 0);
  -- ROM contents
  constant mem : ramtype := (
    0  => x"00500113",
    1  => x"00C00193",
    2  => x"FF718393",
    3  => x"0023E233",
    4  => x"0041F2B3",
    5  => x"004282B3",
    6  => x"02728863",
    7  => x"0041A233",
    8  => x"00020463",
    9  => x"00000293",
    10 => x"0023A233",
    11 => x"005203B3",
    12 => x"402383B3",
    13 => x"0471AA23",
    14 => x"06002103",
    15 => x"005104B3",
    16 => x"008001EF",
    17 => x"00100113",
    18 => x"00910133",
    19 => x"0221A023",
    20 => x"00210063",
    others => x"00000000" -- nop
  );

begin
  -- read memory
  process (a) begin
    rd <= mem(to_integer(unsigned(a(31 downto 2))));
  end process;
end;