library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity adder is
  port
  (
    a, b : in std_logic_vector(31 downto 0);
    y    : out std_logic_vector(31 downto 0));
end;
architecture behave of adder is
  signal y_uns: unsigned(31 downto 0);
begin
  y_uns <= unsigned(a) + unsigned(b);
  y <= std_logic_vector(y_uns);
end;