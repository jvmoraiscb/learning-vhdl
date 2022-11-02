library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
        num1, num2 : in std_logic_vector(3 downto 0);
        mode : in std_logic;
        res : out std_logic_vector(4 downto 0)
    );
end top;

architecture top_arch of top is
begin
    adder_subtractor_unit : entity work.adder_4bits(adder_arch)
        port map(
            num1    => num1,
            num2(3) => (num2(3) xor mode),
            num2(2) => (num2(2) xor mode),
            num2(1) => (num2(1) xor mode),
            num2(0) => (num2(0) xor mode),
            num3    => res,
            mode    => mode
        );

end top_arch;