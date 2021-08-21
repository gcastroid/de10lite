library ieee;
use ieee.std_logic_1164.all;

entity reg is 
   generic(Nbits: integer);
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_en: in std_logic;
	i_data: in std_logic_vector(Nbits-1 downto 0);
   o_data: out std_logic_vector(Nbits-1 downto 0));
end entity;

architecture behave of reg is 

   signal r_data: std_logic_vector(Nbits-1 downto 0);

begin

   process(i_rst, i_clk)
	begin
	   if (i_rst = '0') then
		   r_data <= (others => '0');
		elsif (rising_edge(i_clk)) then
		   if (i_en = '1') then
			   r_data <= i_data;
			end if;
		end if;
	end process;
	
	o_data <= r_data;

end architecture;
