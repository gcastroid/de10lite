library ieee;
use ieee.std_logic_1164.all;

package components is 

component ps2_data_check is
   port(
   i_data: in std_logic_vector(10 downto 0);
   o_data_ok: out std_logic);
end component;

component ps2_shift_reg is
   generic(Nbits: integer);
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_data: in std_logic;
   o_data: out std_logic_vector(Nbits-1 downto 0));
end component;

component seven_seg_anode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(6 downto 0));
end component;

end components;