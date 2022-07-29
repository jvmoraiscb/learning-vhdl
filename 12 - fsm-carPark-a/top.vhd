library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk : in std_logic;
        sw  : in std_logic_vector(1 downto 0);
        led : out std_logic_vector(1 downto 0)
    );
end top;

architecture top_arch of top is
    constant N : integer := 49999999; 
    signal divide_clk : integer range 0 to N;
    signal enable : std_logic;
begin
    fsm_unit: entity work.fsm_carPark(moore_arch)
        port map(
            clk => clk,
            reset => '0',
            enable => enable,
            a => sw(1),
            b => sw(0),
            car_enter => led(1),
            car_exit => led(0)
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