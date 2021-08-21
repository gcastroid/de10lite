library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity en_sync is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_en: in std_logic;
   o_en: out std_logic);
end entity;

architecture behave of en_sync is

   signal r_en: std_logic_vector(2 downto 0);

begin

   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         r_en <= (others => '0');
      elsif (rising_edge(i_clk)) then 
         r_en(0) <= i_en;
         r_en(1) <= r_en(0);
         r_en(2) <= r_en(1);
      end if;
   end process;

   o_en <= r_en(2) and (not r_en(1));

end behave;