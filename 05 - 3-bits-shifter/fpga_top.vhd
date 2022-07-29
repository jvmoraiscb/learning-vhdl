library ieee;
use ieee.std_logic_1164.all;

entity fpga_top is
    port(
        sw : in std_logic_vector(15 downto 0);
        led : out std_logic_vector(15 downto 0)
    );
end fpga_top;

architecture fpga_top_arch of fpga_top is
begin
    top_unit : entity work.top(top_arch)
        port map(
            bits => sw(2 downto 0),
            mode => sw(15 downto 13),
            leds => led(15 downto 13)
        );
end fpga_top_arch;