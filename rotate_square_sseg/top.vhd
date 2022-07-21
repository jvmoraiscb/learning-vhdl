library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk :   in std_logic;
        sw :    in std_logic_vector(15 downto 0);
        sseg :  out std_logic_vector(7 downto 0);
        an :    out std_logic_vector(7 downto 0)
    );
end top;

architecture top_arch of top is
    constant N : integer := 49999999; 
    signal divide_clk : integer range 0 to N;
    signal enable : std_logic;
begin
    fsm_unit: entity work.fsm_sseg(two_seg_arch)
        port map(
            clk => clk,
            reset => '0',
            in0 => "10011100",
            in1 => "10011100",
            in2 => "10011100",
            in3 => "10011100",
            in4 => "10100011",
            in5 => "10100011",
            in6 => "10100011",
            in7 => "10100011",
            an => an,
            sseg => sseg,
            enable => enable,
            en => sw(0),
            cw => sw(1)
        );
    enable <= '1' when divide_clk = N else '0';  
    process (clk)
    begin
        if (clk'event and clk='1') then
            divide_clk <= divide_clk+1;
            if divide_clk = N then
                divide_clk <= 0;
            end if;
        end if;
    end process;
end top_arch;