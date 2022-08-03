library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity test_tb is
end test_tb;

architecture tb_arch of test_tb is
   --declare inputs and initialize them to zero.
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   
   -- define the period of clock here.
   -- it's recommended to use CAPITAL letters to define constants.
   constant CLK_PERIOD : time := 10 ns;
begin    
      -- clock process definitions(clock with 50% duty cycle is generated here.)
      clk_process :process
      begin
           clk <= '0';
           wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
           clk <= '1';
           wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
      end process;
   -- instantiate the circuit under test
   uut : entity work.top(top_arch)
      port map(
         clk    => clk,
         sw    => test_sw,
         led => test_out
      );
   -- test vector generator
    
    -- terminate simulation
    assert false
        report "Simulation Completed"
        severity failure;
   end process;
end tb_arch;