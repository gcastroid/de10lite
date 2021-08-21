library ieee;
use ieee.std_logic_1164.all;

package components is 

component clock_div is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_div: in std_logic_vector(2 downto 0);
   o_en: out std_logic);
end component;

component counter is
   generic(Nbits: integer);
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_en: in std_logic;
   o_count: out std_logic_vector(Nbits-1 downto 0));
end component;

component en_sync is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_en: in std_logic;
   o_en: out std_logic);
end component;

component seven_seg_anode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(6 downto 0));
end component;

end components;