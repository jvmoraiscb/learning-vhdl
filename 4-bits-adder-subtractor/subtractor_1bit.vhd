library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtractor_1bit is
    port(
        a : in std_logic;
        b : in std_logic;
        bi : in std_logic; -- Borrow in
        bo : out std_logic; -- Borrow out
        s : out std_logic
    );
end subtractor_1bit;

architecture subtractor_arch of subtractor_1bit is
begin
    bo <= (not(a) and b) or (not(a) and bi) or (b and bi);
    s <= (a xor b xor bi);

end subtractor_arch;
