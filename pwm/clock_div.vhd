library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_div is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_div: in std_logic_vector(2 downto 0);
   o_en: out std_logic);
end entity;

architecture behave of clock_div is

   signal r_en: std_logic;
   signal s_prescaler: integer range 1 to 128;
   signal r_prescaler_count: unsigned(6 downto 0);

begin

   s_prescaler <=
   1 when i_div = "000" else
   2 when i_div = "001" else
   4 when i_div = "010" else
   8 when i_div = "011" else
   16 when i_div = "100" else
   32 when i_div = "101" else
   64 when i_div = "110" else
   128;

   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         r_prescaler_count <= (others => '0');
         r_en <= '0';
      elsif (rising_edge(i_clk)) then 
         if (to_integer(r_prescaler_count) = s_prescaler - 1) then
            r_prescaler_count <= (others => '0');
            r_en <= '1';
         else
            r_prescaler_count <= r_prescaler_count + 1;
            r_en <= '0';
         end if;
      end if;
   end process;

   o_en <= r_en;

end behave;