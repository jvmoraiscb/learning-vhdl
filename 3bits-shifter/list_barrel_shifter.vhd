--=============================
-- Listing 7.13 barrel shifter
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity shift3mode is
   port(
      a: in std_logic_vector(7 downto 0);
      lar: in std_logic_vector(1 downto 0);
      amt: in std_logic_vector(2 downto 0);
      y: out std_logic_vector(7 downto 0)
   );
end shift3mode ;

architecture direct_arch of shift3mode is
   signal logic_result, arith_result, rot_result:
      std_logic_vector(7 downto 0);
begin
   with amt select
       rot_result<=
          a                             when "000",
          a(0) & a(7 downto 1)          when "001",
          a(1 downto 0) & a(7 downto 2) when "010",
          a(2 downto 0) & a(7 downto 3) when "011",
          a(3 downto 0) & a(7 downto 4) when "100",
          a(4 downto 0) & a(7 downto 5) when "101",
          a(5 downto 0) & a(7 downto 6) when "110",
          a(6 downto 0) & a(7) when others; -- 111
   with amt select
      logic_result<=
         a                         when "000",
         "0"       & a(7 downto 1) when "001",
         "00"      & a(7 downto 2) when "010",
         "000"     & a(7 downto 3) when "011",
         "0000"    & a(7 downto 4) when "100",
         "00000"   & a(7 downto 5) when "101",
         "000000"  & a(7 downto 6) when "110",
         "0000000" & a(7) when others; -- 111
   with amt select
      arith_result<=
         a                             when "000",
         a(7) & a(7 downto 1)          when "001",
         a(7)&a(7)     & a(7 downto 2) when "010",
         a(7)&a(7)&a(7)& a(7 downto 3) when "011",
         a(7)&a(7)&a(7)&a(7)&
             a(7 downto 4)             when "100",
         a(7)&a(7)&a(7)&a(7)&a(7)&
             a(7 downto 5)             when "101",
         a(7)&a(7)&a(7)&a(7)&a(7)&a(7)&
             a(7 downto 6)             when "110",
         a(7)&a(7)&a(7)&a(7)&a(7)&a(7)&a(7)&
             a(7)                      when others;
   with lar select
      y <= logic_result when "00",
           arith_result when "01",
           rot_result   when others;
end direct_arch;


--=============================
-- Listing 7.14
--=============================
architecture shared_arch of shift3mode is
   signal shift_in: std_logic_vector(7 downto 0);
begin
   with lar select
      shift_in <= (others=>'0')  when "00",
                  (others=>a(7)) when "01",
                  a              when others;
   with amt select
      y <= a                                    when "000",
           shift_in(0)          & a(7 downto 1) when "001",
           shift_in(1 downto 0) & a(7 downto 2) when "010",
           shift_in(2 downto 0) & a(7 downto 3) when "011",
           shift_in(3 downto 0) & a(7 downto 4) when "100",
           shift_in(4 downto 0) & a(7 downto 5) when "101",
           shift_in(5 downto 0) & a(7 downto 6) when "110",
           shift_in(6 downto 0) & a(7) when others;
end shared_arch;

