library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk                     : in std_logic;
        SHR_in, cLD, cINC, cSHR : in std_logic;
        L                       : in std_logic_vector(3 downto 0);
        S                       : out std_logic_vector(3 downto 0)
    );
end top;

architecture arch of top is
    signal en              : std_logic;
    signal c               : std_logic_vector(1 downto 0);
    signal S_int, Q, Q_inc : std_logic_vector(3 downto 0);
begin
    S <= Q;
    div_clk : entity work.div_clk(Behavioral)
        port map(
            clk => clk,
            en  => en
        );
    LC : entity work.cod_prio(cond_arch)
        port map(
            r(2)  => cLD,
            r(1)  => cINC,
            r(0)  => cSHR,
            pcode => c
        );
    MUX_4x1_3 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => L(3),
            i(2) => Q_inc(3),
            i(1) => SHR_in,
            i(0) => Q(3),
            c    => c,
            s    => S_int(3)
        );
    MUX_4x1_2 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => L(2),
            i(2) => Q_inc(2),
            i(1) => Q(3),
            i(0) => Q(2),
            c    => c,
            s    => S_int(2)
        );
    MUX_4x1_1 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => L(1),
            i(2) => Q_inc(1),
            i(1) => Q(2),
            i(0) => Q(1),
            c    => c,
            s    => S_int(1)
        );
    MUX_4x1_0 : entity work.mux_4x1(cond_arch)
        port map(
            i(3) => L(0),
            i(2) => Q_inc(0),
            i(1) => Q(1),
            i(0) => Q(0),
            c    => c,
            s    => S_int(0)
        );
    FF_D_3 : entity work.FF_D(Behavioral)
        port map(
            clk => clk,
            D   => S_int(3),
            e   => en,
            Q   => Q(3)
        );
    FF_D_2 : entity work.FF_D(Behavioral)
        port map(
            clk => clk,
            D   => S_int(2),
            e   => en,
            Q   => Q(2)
        );
    FF_D_1 : entity work.FF_D(Behavioral)
        port map(
            clk => clk,
            D   => S_int(1),
            e   => en,
            Q   => Q(1)
        );
    FF_D_0 : entity work.FF_D(Behavioral)
        port map(
            clk => clk,
            D   => S_int(0),
            e   => en,
            Q   => Q(0)
        );
    INC_4bits : entity work.inc_4bits(Behavioral)
        port map(
            inc_in    => Q,
            inc_out   => Q_inc
        );
end arch;

