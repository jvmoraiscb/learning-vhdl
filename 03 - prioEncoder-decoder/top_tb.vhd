library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture tb_arch of top_tb is
    signal test_code: std_logic_vector(2 downto 0);
    signal test_code_d: std_logic_vector(3 downto 0);
    signal test_pcode: std_logic_vector(3 downto 0);
    signal test_pcode_en: std_logic_vector(2 downto 0);

begin
    test_unit: entity work.top(top_arch)
        port map(
            code          => test_code,
            code_decoder  => test_code_d,
            pcode         => test_pcode,
            pcode_encoder => test_pcode_en
        );
        -- test
        process
        begin
            test_code <= "000";
            test_pcode <= "0000";
            wait for 200 ns;

            test_code <= "100";
            test_pcode <= "0001";
            wait for 200 ns;
            
            test_code <= "101";
            test_pcode <= "0010";
            wait for 200 ns;

            test_code <= "110";
            test_pcode <= "0100";
            wait for 200 ns;

            test_code <= "111";
            test_pcode <= "1000";
            wait for 200 ns;
        end process;  
end tb_arch;