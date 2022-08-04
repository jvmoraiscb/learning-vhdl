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
signal count      : std_logic_vector(3 downto 0); -- limit is 9 cars
signal reg        : unsigned(3 downto 0) := (others=>'0');
signal reg_next   : unsigned(3 downto 0) := (others=>'0');
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
            hex_in  => count(3 downto 0),
            dp_in => '1',
            an    => an(7 downto 0),
            sseg  => sseg
        );

    process(clk)
    begin
        if(clk'event and clk = '1') then
            reg <= reg_next;
        end if;
    end process;
    
    process(inc, dec)
    begin
        if(inc = '1') then
            reg_next <= reg + 1;
        elsif(dec = '1') then
            reg_next <= reg - 1;
        else
            reg_next <= reg;
        end if;
    end process;
    
    count <= std_logic_vector(reg);

end top_arch;