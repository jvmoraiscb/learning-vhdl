library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk  : in std_logic;
        btn  : in std_logic_vector(1 downto 0);
        an   : out std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(7 downto 0)
    );
end top;

architecture top_arch of top is
signal inc, dec   : std_logic;
signal db_a, db_b : std_logic;  
signal count      : std_logic_vector(15 downto 0); -- limit is 9999 cars
signal reg        : unsigned(15 downto 0) := (others=>'0');
signal reg_next   : unsigned(15 downto 0) := (others=>'0');
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
    disp_unit: entity work.fsm_dispHexMux(arch)
        port map(
            clk   => clk,
            reset => '0',
            hex3  => count(15 downto 12),
            hex2  => count(11 downto 8),
            hex1  => count(7 downto 4),
            hex0  => count(3 downto 0),
            dp_in => "1111",
            an    => an(3 downto 0),
            sseg  => sseg
        );
    an(7 downto 4) <= "1111";

    process(clk)
    begin
        if(clk'event and clk = '1') then
            reg <= reg_next;
        end if;
    end process;
    
    reg_next <= reg + 1 when (inc = '1')             else
                reg - 1 when (dec = '1' and reg > 0) else
                reg;
    
    count <= std_logic_vector(reg);

end top_arch;