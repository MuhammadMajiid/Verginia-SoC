library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity aludec is
  port
  (
    opb5       : in std_logic;
    funct3     : in std_logic_vector(2 downto 0);
    funct7b5   : in std_logic;
    ALUOp      : in std_logic_vector(1 downto 0);
    ALUControl : out std_logic_vector(2 downto 0));
end;
architecture behave of aludec is
  signal RtypeSub : std_logic;
begin
  RtypeSub <= funct7b5 and opb5;
  -- TRUE for R–type subtract
  process (opb5, funct3, funct7b5, ALUOp, RtypeSub) begin
    case ALUOp is
      when "00" => ALUControl <= "000";
        -- addition
      when "01" => ALUControl <= "001";
        -- subtraction
      when others => 
        case funct3 is -- R–type or I–type ALU

            when "000" =>
              if RtypeSub = '1' then
                ALUControl <= "001";
                -- sub
              else
                ALUControl <= "000";
                -- add, addi
              end if;
          when "010" => ALUControl <= "101";
          -- slt, slti
          when "110" => ALUControl <= "011";
          -- or, ori
          when "111" => ALUControl <= "010";
          -- and, andi
          when others => ALUControl <= "---";
          -- unknown
        end case;
    end case;
  end process;
end architecture;