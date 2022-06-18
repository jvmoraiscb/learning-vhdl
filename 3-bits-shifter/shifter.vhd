library ieee;
use ieee.std_logic_1164.all;

entity shifter is
    port(
        mode : in std_logic_vector(1 downto 0);
        bits_in : in std_logic_vector(2 downto 0);
        bits_out : out std_logic_vector(2 downto 0)
    );
end shifter;

architecture shifter_arch of shifter is
begin
    process(mode)
    begin
        -- Deslocamento para a direita
        if mode = "11" then
            bits_out(2) <= '0';
            bits_out(1 downto 0) <= bits_in(2 downto 1);  
        -- Deslocamento circular para a direita
        elsif mode = "10" then
            bits_out(2) <= bits_in(0);
            bits_out(1 downto 0) <= bits_in(2 downto 1);
        -- Deslocamento circular para a esquerda
        elsif mode = "01" then
            bits_out(0) <= '0';
            bits_out(2 downto 1) <= bits_in(1 downto 0);
        else
            bits_out <= bits_in;
        end if;
    end process;
end shifter_arch;