library ieee;
use ieee.std_logic_1164.all;

entity prio_encoder is
    port(
        bits_in : in std_logic_vector(1 downto 0);
        bits_out : out std_logic_vector(1 downto 0)
    );
end prio_encoder;

architecture prio_encoder_arch of prio_encoder is
begin
    bits_out <= "10" when (bits_in(1) = '1') else
                "01" when (bits_in(0) = '1') else
                "00";
end prio_encoder_arch;