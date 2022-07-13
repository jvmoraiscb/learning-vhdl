-- Listing 5.1
library ieee;
use ieee.std_logic_1164.all;
entity fsm_eg is
   port(
      clk, reset, enable : in  std_logic;
      in3, in2, in1, in0 : in  std_logic_vector(7 downto 0);
      in7, in6, in5, in4 : in  std_logic_vector(7 downto 0);
      an                 : out std_logic_vector(7 downto 0);
      sseg               : out std_logic_vector(7 downto 0)
   );
end fsm_eg;

-- Listing 5.2
architecture two_seg_arch of fsm_eg is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;
begin
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0;
      elsif (clk'event and clk = '1') then
         if (enable = '1') then
            state_reg <= state_next;
         end if;
      end if;
   end process;
   -- next-state/output logic
   process(state_reg, in0, in1, in2, in3, in4, in5, in6, in7)
   begin
      state_next <= state_reg;          -- default back to same state
        case state_reg is
            when s0 =>
                an   <= "11111110";
                sseg <= in0;
                state_next <= s1;
            when s1 =>
                an   <= "11111101";
                sseg <= in1;
                state_next <= s2;
            when s2 =>
                an   <= "11111011";
                sseg <= in2;
                state_next <= s3;
            when s3 =>
                an   <= "11110111";
                sseg <= in3;
                state_next <= s4;
            when s4 =>
                an   <= "11101111";
                sseg <= in4;
                state_next <= s5;
            when s5 =>
                an   <= "11011111";
                sseg <= in5;
                state_next <= s6;
            when s6 =>
                an   <= "10111111";
                sseg <= in6;
                state_next <= s7;
            when s7 =>
                an   <= "01111111";
                sseg <= in7;
                state_next <= s0;
      end case;
   end process;
end two_seg_arch;

--architecture mult_seg_arch of fsm_eg is
--   type eg_state_type is (s0, s1, s2);
--   signal state_reg, state_next : eg_state_type;
--begin
--   -- state register
--   process(clk, reset)
--   begin
--      if (reset = '1') then
--         state_reg <= s0;
--      elsif (clk'event and clk = '1') then
--         state_reg <= state_next;
--      end if;
--   end process;
--   -- next-state logic
--   process(state_reg, a, b)
--   begin
--      case state_reg is
--         when s0 =>
--            if a = '1' then
--               if b = '1' then
--                  state_next <= s2;
--               else
--                  state_next <= s1;
--               end if;
--            else
--               state_next <= s0;
--            end if;
--         when s1 =>
--            if (a = '1') then
--               state_next <= s0;
--            else
--               state_next <= s1;
--            end if;
--         when s2 =>
--            state_next <= s0;
--      end case;
--   end process;
--   -- Moore output logic
--   process(state_reg)
--   begin
--      case state_reg is
--         when s0 | s1 =>
--            y1 <= '0';
--         when s2 =>
--            y1 <= '1';
--      end case;
--   end process;
--   -- Mealy output logic
--   process(state_reg, a, b)
--   begin
--      case state_reg is
--         when s0 =>
--            if (a = '1') and (b = '1') then
--               y0 <= '1';
--            else
--               y0 <= '0';
--            end if;
--         when s1 | s2 =>
--            y0 <= '0';
--      end case;
--   end process;
--end mult_seg_arch;