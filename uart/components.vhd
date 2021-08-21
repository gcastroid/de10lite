library ieee;
use ieee.std_logic_1164.all;

package components is 

component reg is 
   generic(Nbits: integer);
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_en: in std_logic;
	i_data: in std_logic_vector(Nbits-1 downto 0);
   o_data: out std_logic_vector(Nbits-1 downto 0));
end component;

component seven_seg_anode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(6 downto 0));
end component;

component uart_rx is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_rx: in std_logic;
   o_rc: out std_logic;
   o_re: out std_logic;
   o_rx: out std_logic_vector(7 downto 0));
end component;

component uart_tx is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_te: in std_logic;
   i_tx: in std_logic_vector(7 downto 0);
   o_tb: out std_logic;
   o_tc: out std_logic;
   o_tx: out std_logic);
end component;

end components;