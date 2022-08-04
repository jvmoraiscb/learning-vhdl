library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity reg is
    port(
        clk, reset, enable : in std_logic;
        inc, dec           : in std_logic;
        counter            : out std_logic_vector(7 downto 0)
    );
end reg;

architecture arch of reg is
    signal reg        : unsigned(7 downto 0) := (others=>'0');
    signal reg_next   : unsigned(7 downto 0) := (others=>'0');
begin
    -- register
    process(clk,reset)
    begin
       if (reset='1') then
          reg <= (others=>'0');
       elsif (clk'event and clk='1') then
          if (enable='1') then
             reg <= reg_next;
          end if;
       end if;
    end process;
    
    process(inc, dec)
    begin
        if(inc = '1') then
            reg_next <= reg + 1;
        elsif(dec = '1') then
            reg_next <= reg - 1;
        else
            reg_next <= reg;
        end if;
    end process;

    counter <= std_logic_vector(reg);
end arch;
