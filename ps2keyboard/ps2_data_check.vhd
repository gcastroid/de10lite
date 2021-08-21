library ieee;
use ieee.std_logic_1164.all;

entity ps2_data_check is
   port(
   i_data: in std_logic_vector(10 downto 0);
   o_data_ok: out std_logic);
end entity;

architecture behave of ps2_data_check is 
 
   signal s_start: std_logic;
   signal s_code: std_logic_vector(7 downto 0);
   signal s_parity: std_logic;
   signal s_stop: std_logic;

   signal s_xor: std_logic_vector(6 downto 0);
   signal s_parity_ok: std_logic;

begin

   s_start <= i_data(0);
   s_code <= i_data(8 downto 1);
   s_parity <= i_data(9);
   s_stop <= i_data(10);

   s_xor(0) <= s_code(0) xor s_code(1);
   s_xor(1) <= s_code(2) xor s_code(3);
   s_xor(2) <= s_code(4) xor s_code(5);
   s_xor(3) <= s_code(6) xor s_code(7);
   s_xor(4) <= s_xor(0) xor s_xor(1);
   s_xor(5) <= s_xor(2) xor s_xor(3);
   s_xor(6) <= s_xor(4) xor s_xor(5);

   s_parity_ok <= '1' when s_parity = s_xor(6) else '0';

   o_data_ok <= s_parity_ok and (not s_start) and s_stop;

end behave;