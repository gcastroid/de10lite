library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity ps2_keyboard is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_ps2_clk: in std_logic;
   i_ps2_data: in std_logic;
   o_disp1: out std_logic_vector(6 downto 0);
   o_disp2: out std_logic_vector(6 downto 0));
end entity;

architecture behave of ps2_keyboard is 

   -- pin assignments
   attribute chip_pin: string;
   attribute chip_pin of i_rst: signal is "b8";
   attribute chip_pin of i_clk: signal is "p11";
   attribute chip_pin of i_ps2_clk: signal is "v9";
   attribute chip_pin of i_ps2_data: signal is "v10";
   attribute chip_pin of o_disp1: signal is "c17, d17, e16, c16, c15, e15, c14";
   attribute chip_pin of o_disp2: signal is "b17, a18, a17, b16, e18, d18, c18";

   -- signals  
   signal s_ps2_data: std_logic_vector(10 downto 0);

begin

   -- shift register
   shift_register: ps2_shift_reg 
   generic map (11) 
   port map(
   i_rst => i_rst,
   i_clk => i_ps2_clk,
   i_data => i_ps2_data,
   o_data => s_ps2_data);

   -- display hex decoders
   display1: seven_seg_anode 
   port map(
   i_binary => s_ps2_data(4 downto 1),
   o_display => o_disp1);

   display2: seven_seg_anode 
   port map(
   i_binary => s_ps2_data(8 downto 5), 
   o_display => o_disp2);

end behave;