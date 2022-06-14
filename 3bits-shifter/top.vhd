library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        bits : in std_logic_vector(2 downto 0);
        mode : in std_logic_vector(2 downto 0);
        leds : out std_logic_vector(2 downto 0)
    );
end top;

architecture top_arch of top is
    signal prio_mode : std_logic_vector(1 downto 0);
begin
end top_arch;