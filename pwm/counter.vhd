library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
   generic(Nbits: integer);
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_en: in std_logic;
   o_count: out std_logic_vector(Nbits-1 downto 0));
end entity;

architecture behave of counter is

   signal r_count: unsigned(Nbits-1 downto 0);

begin

   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         r_count <= (others => '0');
      elsif (rising_edge(i_clk)) then 
         if (i_en = '1') then
            r_count <= r_count + 1;
         end if;
      end if;
   end process;

   o_count <= std_logic_vector(r_count);

end behave;