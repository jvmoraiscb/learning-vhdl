library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
        num1, num2 : in std_logic_vector(3 downto 0);
        mode : in std_logic_vector(1 downto 0);
        res : out std_logic_vector(4 downto 0)
    );
end top;

architecture top_arch of top is
    signal prio_mode : std_logic_vector(2 downto 0);
    signal num_b : std_logic_vector(3 downto 0);
begin
    prio_unit : entity work.prio_encoder(prio_encoder_arch)
        port map(
            bits_in => mode;
            bits_out => prio_mode
        );
    process(prio_mode, num1, num2)
    begin
        if prio_mode = "10" then
            adder_unit : entity work.adder_4bits(adder_arch)
                port map(
                    num1 => num1;
                    num2 => num2;
                    res => res;
                );
        elsif prio_mode = "01" then
            



end top_arch;
