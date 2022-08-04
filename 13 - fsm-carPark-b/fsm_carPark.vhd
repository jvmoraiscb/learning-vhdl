library ieee;
use ieee.std_logic_1164.all;
entity fsm_carPark is
   port(
      clk, reset, enable  : in  std_logic;
      a, b                : in  std_logic;
      car_enter, car_exit : out  std_logic
   );
end fsm_carPark;

-- Listing 5.2
architecture moore_arch of fsm_carPark is
   type eg_state_type is (start, a_on, ab_on, b_on, up, b_on2, ba_on, a_on2, down);
   signal state_reg, state_next : eg_state_type;
begin
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= start;
      elsif (clk'event and clk = '1') then
         if (enable = '1') then
            state_reg <= state_next;
         end if;
      end if;
   end process;
   -- next-state/output logic
   process(state_reg, a, b)
   begin
      state_next <= state_reg; -- default back to same state
        case state_reg is
            when start =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '1') then
                  state_next <= a_on;
               elsif(a = '0' and b = '1') then
                  state_next <= b_on2;
               else -- not(a) and not(b)
                  state_next <= start;
               end if;
            
            -- car_enter   
            when a_on =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '1' and b = '1') then
                  state_next <= ab_on;
               elsif(a = '0') then
                  state_next <= start;
               else -- a and not(b)
                  state_next <= a_on;
               end if;
            when ab_on =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '0' and b = '1') then
                  state_next <= b_on;
               elsif(b = '0') then
                  state_next <= a_on;
               else -- a and b
                  state_next <= ab_on;
               end if;
            when b_on =>
               car_enter <= '0';
               car_exit <= '0';
               if (b = '0') then
                  state_next <= up;
               elsif(a = '1' and b = '1') then
                  state_next <= ab_on;
               else -- not(a) and b
                  state_next <= b_on;
               end if;
            when up =>
               car_enter <= '1';
               car_exit <= '0';
               state_next <= start;

            -- car_exit
            when b_on2 =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '1' and b = '1') then
                  state_next <= ba_on;
               elsif(b = '0') then
                  state_next <= start;
               else -- not(a) and b
                  state_next <= b_on2;
               end if;
            when ba_on =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '1' and b = '0') then
                  state_next <= a_on2;
               elsif(a = '0') then
                  state_next <= b_on2;
               else -- a and b
                  state_next <= a_on2;
               end if;
            when a_on2 =>
               car_enter <= '0';
               car_exit <= '0';
               if (a = '0') then
                  state_next <= down;
               elsif(a = '1' and b = '1') then
                  state_next <= ba_on;
               else -- a and not(b)
                  state_next <= a_on2;
               end if;
            when down =>
               car_enter <= '0';
               car_exit <= '1';
               state_next <= start;    
      end case;
   end process;
end moore_arch;