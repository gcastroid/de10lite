library ieee;
use ieee.std_logic_1164.all;

entity ps2_shift_reg is
   generic(Nbits: integer);
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_data: in std_logic;
   o_data: out std_logic_vector(Nbits-1 downto 0));
end entity;

architecture behave of ps2_shift_reg is 

   signal s_shift_data: std_logic_vector(Nbits-1 downto 0);

begin

   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         s_shift_data <= (others => '0');
      elsif (falling_edge(i_clk)) then
         s_shift_data(Nbits-2 downto 0) <= s_shift_data(Nbits-1 downto 1);
         s_shift_data(Nbits-1) <= i_data;
      end if;
   end process;
   
   o_data <= s_shift_data;

end architecture;