library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture top_tb_arch of top_tb is
    signal test_mode : std_logic_vector(2 downto 0); 
    signal test_bits : std_logic_vector(2 downto 0);
    signal test_leds : std_logic_vector(2 downto 0);
begin
    test_unit : entity work.top(top_arch)
        port map(
            mode => test_mode,
            bits => test_bits,
            leds => test_leds 
        );
    process
    begin
        test_mode <= "111";
        test_bits <= "101";
        wait for 100 ns;
        test_mode <= "011";
        test_bits <= "101";
        wait for 100 ns;
        test_mode <= "001";
        test_bits <= "101";
        wait for 100 ns;
        test_mode <= "000";
        test_bits <= "101";
        wait for 100 ns;
        
        test_mode <= "100";
        test_bits <= "111";
        wait for 100 ns;
        test_mode <= "010";
        test_bits <= "111";
        wait for 100 ns;
        test_mode <= "001";
        test_bits <= "111";
        wait for 100 ns;
        test_mode <= "000";
        test_bits <= "111";
        wait for 100 ns;
    end process;

end top_tb_arch;