library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity fsm_dispHexMux is
   port(
      clk, reset : in  std_logic;
      hex_in     : in  std_logic_vector(3 downto 0);
      hex_in2   : in  std_logic_vector(3 downto 0);
      dp_in      : in  std_logic_vector(7 downto 0);
      an         : out std_logic_vector(7 downto 0);
      sseg       : out std_logic_vector(7 downto 0)
   );
end fsm_dispHexMux;

architecture arch of fsm_dispHexMux is
   -- each 7-seg led enabled (2^18/4)*10 ns (16 ms)
   constant N    : integer := 18;
   signal q_reg  : unsigned(N - 1 downto 0);
   signal q_next : unsigned(N - 1 downto 0);
   signal sel    : std_logic_vector(1 downto 0);
   signal hex    : std_logic_vector(3 downto 0);
   signal dp     : std_logic;
begin
   -- register
   process(clk, reset)
   begin
      if reset = '1' then
         q_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         q_reg <= q_next;
      end if;
   end process;
   -- next-state logic for the counter
   q_next <= q_reg + 1;
   -- 2 MSBs of counter to control 4-to-1 multiplexing
   sel <= std_logic_vector(q_reg(N - 1 downto N - 2));
   process(sel, hex_in, hex_in2, dp_in)
   begin
      case sel is
         when "00" =>
            an(7 downto 0) <= "11111110";
            hex            <= hex_in;
            dp             <= dp_in(0);
         when others =>
            an(7 downto 0) <= "11111101";
            hex            <= hex_in2;
            dp             <= dp_in(1);
      end case;
   end process;
   -- hex-to-7-segment led decoding
   with hex select 
      sseg(6 downto 0) <=
         "1000000" when "0000",
         "1111001" when "0001",
         "0100100" when "0010",
         "0110000" when "0011",
         "0011001" when "0100",
         "0010010" when "0101",
         "0000010" when "0110",
         "1111000" when "0111",
         "0000000" when "1000",
         "0010000" when others;   --9
   -- decimal point
   sseg(7) <= dp;
end arch;