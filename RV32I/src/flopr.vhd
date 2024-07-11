library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity flopr is
  generic
    (width : integer);
  port
  (
    clk, reset : in std_logic;
    d          : in std_logic_vector(width-1 downto 0);
    q          : out std_logic_vector(width-1 downto 0));
end;
architecture asynchronous of flopr is
begin
  process (clk, reset) begin
    if reset = '1' then
      q <= (others => '0');
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;
end;