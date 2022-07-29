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
    mode_unit : entity work.prio_encoder(prio_encoder_arch)
        port map(
            bits_in => mode,
            bits_out => prio_mode
        );
    shifter_unit : entity work.shifter(shifter_arch)
        port map(
            mode => prio_mode,
            bits_in => bits,
            bits_out => leds
        );
    
end top_arch;