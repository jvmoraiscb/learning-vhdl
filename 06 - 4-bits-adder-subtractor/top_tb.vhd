library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture tb_arch of top_tb is
    signal test_num1, test_num2 : std_logic_vector(3 downto 0);
    signal test_mode : std_logic;
    signal test_res : std_logic_vector(4 downto 0);
begin
    test_unit : entity work.top(top_arch)
        port map(
            num1 => test_num1,
            num2 => test_num2,
            mode => test_mode,
            res => test_res
        );
    process
    begin
        test_num1 <= "0011";
        test_num2 <= "0101";
        test_mode <= '1';
        wait for 250 ns;
        test_num1 <= "0011";
        test_num2 <= "0101";
        test_mode <= '0';
        wait for 250 ns;

        test_num1 <= "1001";
        test_num2 <= "1101";
        test_mode <= '1';
        wait for 250 ns;
        test_num1 <= "1000";
        test_num2 <= "0101";
        test_mode <= '0';
        wait for 250 ns;
    end process;
end tb_arch;