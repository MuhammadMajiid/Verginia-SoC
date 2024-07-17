library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity alu is
  port(
      a, b       : in std_logic_vector(31 downto 0);
      ALUControl : in std_logic_vector(2 downto 0);
      ALUResult  : out std_logic_vector(31 downto 0);
      Zero       : out std_logic);
end;
architecture rtl of alu is
  -- signal ops : std_logic_vector(2 downto 0):="000";
  signal ALUResult_uns : unsigned(31 downto 0);
begin
  process (a,b,ALUControl,ALUResult_uns)
  begin
    case ALUControl is
      when "000" =>
        ALUResult_uns <= unsigned(a) + unsigned(b);
  
      when "001" =>
        ALUResult_uns <= unsigned(a) - unsigned(b);
      
      when "010" =>
       ALUResult_uns <= unsigned(a) and unsigned(b);
      
      when "011" =>
        ALUResult_uns <= unsigned(a) or unsigned(b);
        
      when "101" =>
        if a < b then
          ALUResult_uns <= x"00000001";
        else
          ALUResult_uns <= x"00000000";
        end if;
    
      when others =>
      ALUResult_uns <= x"00000000";
    end case;
  
    if ALUResult_uns = x"00000000" then
      Zero <= '1';
    else 
      Zero <= '0';
    end if;
  end process;
  ALUResult <= std_logic_vector(ALUResult_uns);
end architecture;