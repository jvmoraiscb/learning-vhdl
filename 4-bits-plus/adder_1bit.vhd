library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_1bit is
    port(
        a : in std_logic;
        b : in std_logic;
        ci : in std_logic;
        co : out std_logic;
        s : out std_logic
    );
end adder_1bit;

architecture adder_arch of adder_1bit is
begin
    co <= (a and b) or (a and ci) or (b and ci);
    s <= (a xor b xor ci);

end adder_arch;
