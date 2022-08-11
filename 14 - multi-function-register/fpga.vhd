library ieee;
use ieee.std_logic_1164.all;

entity fpga is
    port(
        clk : in std_logic;
        sw  : in std_logic_vector(7 downto 0);
        led : out std_logic_vector(3 downto 0)
    );
end fpga;

architecture arch of fpga is 
begin
    top : entity work.top(arch)
        port map(
            clk    => clk,
            SHR_in => sw(4),
            cLD    => sw(7),
            cINC   => sw(6),
            cSHR   => sw(5),
            L      => sw(3 downto 0),
            S      => led
        );
end arch;