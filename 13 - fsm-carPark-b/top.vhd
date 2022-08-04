library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk  : in std_logic;
        btn  : in std_logic_vector(2 downto 0);
        an   : out std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(7 downto 0)
    );
end top;

architecture top_arch of top is
signal inc, dec         : std_logic;
signal db_a, db_b, db_c : std_logic;  
signal counter          : std_logic_vector(7 downto 0); -- limit is 9 cars
begin
    carPark_unit: entity work.fsm_carPark(moore_arch)
        port map(
            clk       => clk,
            reset     => '0',
            enable    => '1',
            a         => db_a,
            b         => db_b,
            car_enter => inc,
            car_exit  => dec 
        );
    db_a_unit: entity work.fsm_db(arch)
        port map(
            clk   => clk,
            reset => '0',
            sw    => btn(0),
            db    => db_a
        );
    db_b_unit: entity work.fsm_db(arch)
        port map(
            clk   => clk,
            reset => '0',
            sw    => btn(1),
            db    => db_b
        );
     db_c_unit: entity work.fsm_db(arch)
        port map(
            clk   => clk,
            reset => '0',
            sw    => btn(2),
            db    => db_c
        );
    disp_unit: entity work.fsm_dispHexMux(arch)
        port map(
            clk     => clk,
            reset   => '0',
            hex_in  => counter(3 downto 0),
            hex_in2 => counter(7 downto 4),
            dp_in   => "11111111",
            an      => an(7 downto 0),
            sseg    => sseg
        );
    counter_unit: entity work.reg(arch)
        port map(
            clk     => clk,
            reset   => db_c,
            enable  => '1',
            inc     => inc,
            dec     => dec,
            counter => counter
        );

end top_arch;