library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtractor_4bits is
    port(
        num1, num2 : in std_logic_vector(3 downto 0);
        num3 : out std_logic_vector(4 downto 0)
    );
end subtractor_4bits;

architecture subtractor_arch of subtractor_4bits is
    signal bo0, bo1, bo2, bo3 : std_logic;
    signal res : std_logic_vector(4 downto 0); 
begin
    subtractor_a: entity work.subtractor_1bit(subtractor_arch)
    port map(
        a => num1(0),
        b => num2(0),
        bi => '0',
        bo => bo0,
        s => res(0)
    );
    
    subtractor_b: entity work.subtractor_1bit(subtractor_arch)
    port map(
        a => num1(1),
        b => num2(1),
        bi => bo0,
        bo => bo1,
        s => res(1)
        );
        
    subtractor_c: entity work.subtractor_1bit(subtractor_arch)
    port map(
        a => num1(2),
        b => num2(2),
        bi => bo1,
        bo => bo2,
        s => res(2)
    );
    
    subtractor_d: entity work.subtractor_1bit(subtractor_arch)
    port map(
        a => num1(3),
        b => num2(3),
        bi => bo2,
        bo => res(4),
        s => res(3)
    );
    num3 <= res when res(4) = '0' else
            "10000";  

end subtractor_arch;
