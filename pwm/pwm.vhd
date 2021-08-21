library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity pwm is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_prescaler: in std_logic;
   i_duty: in std_logic_vector(9 downto 0);
   o_disp1: out std_logic_vector(6 downto 0);
   o_pwm: out std_logic);
end entity;

architecture behave of pwm is

   -- Pin assignments
   attribute chip_pin: string;
   attribute chip_pin of i_clk: signal is "p11";
   attribute chip_pin of i_rst: signal is "b8";
   attribute chip_pin of i_prescaler: signal is "a7";
   attribute chip_pin of i_duty: signal is "f15, b14, a14, a13, b12, a12, c12, d12, c11, c10";
   attribute chip_pin of o_disp1: signal is "c17, d17, e16, c16, c15, e15, c14";
   attribute chip_pin of o_pwm: signal is "a8";
   
   signal s_count: std_logic_vector(9 downto 0);
   signal s_count_en: std_logic;
   
   signal s_prescaler_disp: std_logic_vector(3 downto 0);
   signal s_prescaler: std_logic_vector(2 downto 0);
   signal s_prescaler_sel: std_logic;

begin

   -- prescaler select 
   enable_sync: en_sync 
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_en => i_prescaler,
   o_en => s_prescaler_sel);

   prescaler_counter: counter
   generic map(3)
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_en => s_prescaler_sel,
   o_count => s_prescaler);

   s_prescaler_disp <= '0' & s_prescaler;

   -- prescaler display
   prescaler_disp: seven_seg_anode
   port map(
   i_binary => s_prescaler_disp,
   o_display => o_disp1);

   -- clock divider
   clk_div1: clock_div
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_div => s_prescaler,
   o_en => s_count_en);
   
   -- counter
   counter1: counter 
   generic map(10)
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_en => s_count_en,
   o_count => s_count);

   -- pwm output
   o_pwm <= '1' when unsigned(s_count) < unsigned(i_duty) else '0';

end behave;