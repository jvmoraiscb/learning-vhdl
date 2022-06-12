library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk : in std_logic;
        hex0, hex1, hex2, hex3 : in std_logic_vector(3 downto 0);
        sseg : out std_logic_vector(7 downto 0);
        an : out std_logic_vector(7 downto 0)
    );
end top;

architecture top_arch of top is
    signal sseg0, sseg1, sseg2, sseg3, sseg4, sseg5, sseg6, sseg7 : std_logic_vector(7 downto 0);
    signal hex4, hex5, hex6, hex7 : std_logic_vector(3 downto 0);
begin
    sseg0_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex0,
            dp => '1',
            sseg => sseg0
        );
    sseg1_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex1,
            dp => '1',
            sseg => sseg1
        );
    sseg2_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex2,
            dp => '1',
            sseg => sseg2
        );
    sseg3_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex3,
            dp => '1',
            sseg => sseg3
        );
    sseg4_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex4,
            dp => '1',
            sseg => sseg4
        );
    sseg5_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex5,
            dp => '1',
            sseg => sseg5
        );
    sseg6_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex6,
            dp => '1',
            sseg => sseg6
        );
    sseg7_unit : entity work.hex_to_sseg(arch)
        port map(
            hex => hex7,
            dp => '1',
            sseg => sseg7
        );
    hex4 <= std_logic_vector(unsigned(hex0)+1);
    hex5 <= std_logic_vector(unsigned(hex1)+1);
    hex6 <= std_logic_vector(unsigned(hex2)+1);
    hex7 <= std_logic_vector(unsigned(hex3)+1);
    
    led_mux8_unit: entity work.led_mux8(arch)
        port map(
            clk => clk,
            reset => '0',
            in0 => sseg0,
            in1 => sseg1,
            in2 => sseg2,
            in3 => sseg3,
            in4 => sseg4,
            in5 => sseg5,
            in6 => sseg6,
            in7 => sseg7,
            an => an,
            sseg => sseg
        );
end top_arch;