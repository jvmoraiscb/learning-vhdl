library ieee;
use ieee.std_logic_1164.all;

entity top is
port(
	clk: in std_logic;
	sseg: out std_logic_vector(7 downto 0);
	an: out std_logic_vector(7 downto 0)
);
end top;

architecture top_arch of top is
constant N : integer := 9999; 
signal divide_clk : integer range 0 to N;
signal enable : std_logic;

begin
    top_unit: entity work.fsm_eg(two_seg_arch)
        port map(
            enable => enable,
            clk => clk,
            reset => '0',
            sseg => sseg,
            an => an,
            in7 => "11000000",
            in6 => "11111001",
            in5 => "10100100",
            in4 => "10110000",
            in3 => "10011001",
            in2 => "10010010",
            in1 => "10000010",
            in0 => "11111000"  
        );
    enable <= '1' when divide_clk = N else '0';  
    PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            divide_clk <= divide_clk+1;
            IF divide_clk = N THEN
                divide_clk <= 0;
            END IF;
        END IF;
    END PROCESS;
end top_arch;

