library ieee;
use ieee.std_logic_1164.all;

entity fpga_top is
    port(
        clk : in std_logic;
        sw : in std_logic_vector(15 downto 0);
        sseg : out std_logic_vector(7 downto 0);
        an : out std_logic_vector(7 downto 0)
    );
end fpga_top;

architecture fpga_top_arch of fpga_top is
begin
    top_unit : entity work.top(top_arch)
        port map(
            clk => clk,
            hex0 => sw(3 downto 0),
            hex1 => sw(7 downto 4),
            hex2 => sw(11 downto 8),
            hex3 => sw(15 downto 12),
            sseg => sseg,
            an => an
        );
end fpga_top_arch;