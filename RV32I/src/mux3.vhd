library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity mux3 is
  generic
    (width : integer := 8);
  port
  (
    d0, d1, d2 : in std_logic_vector(width - 1 downto 0);
    s          : in std_logic_vector(1 downto 0);
    y          : out std_logic_vector(width - 1 downto 0));
end;
architecture behave of mux3 is
begin
  process (d0, d1, d2, s) begin
    if (s = "00") then
      y <= d0;
    elsif (s = "01") then
      y <= d1;
    elsif (s = "10") then
      y <= d2;
    end if;
  end process;
end;