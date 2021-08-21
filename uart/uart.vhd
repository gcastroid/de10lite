library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity uart is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_rx: in std_logic;
   o_tx: out std_logic;
   o_re: out std_logic;
   o_rc: out std_logic;
   o_tb: out std_logic;
   o_tc: out std_logic;
   o_disp1: out std_logic_vector(6 downto 0);
   o_disp2: out std_logic_vector(6 downto 0));
end entity;

architecture behave of uart is

   attribute chip_pin: string;
   attribute chip_pin of i_clk: signal is "p11";
   attribute chip_pin of i_rst: signal is "b8";
   attribute chip_pin of i_rx: signal is "v10";
   attribute chip_pin of o_tx: signal is "v9";
   attribute chip_pin of o_re: signal is "a8";
   attribute chip_pin of o_rc: signal is "a9";
   attribute chip_pin of o_tb: signal is "a10";
   attribute chip_pin of o_tc: signal is "b10";
   attribute chip_pin of o_disp1: signal is "c17, d17, e16, c16, c15, e15, c14";
   attribute chip_pin of o_disp2: signal is "b17, a18, a17, b16, e18, d18, c18";

   signal s_rx: std_logic_vector(7 downto 0);
   signal s_rc: std_logic;

begin

   rx: uart_rx 
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_rx => i_rx,
   o_rc => s_rc,
   o_re => o_re,
   o_rx => s_rx);

   o_rc <= s_rc;

   tx: uart_tx 
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_te => s_rc,
   i_tx => s_rx,
   o_tb => o_tb,
   o_tc => o_tc,
   o_tx => o_tx);

   -- display hex decoders
   display1: seven_seg_anode 
   port map(
   i_binary => s_rx(3 downto 0),
   o_display => o_disp1);

   display2: seven_seg_anode 
   port map(
   i_binary => s_rx(7 downto 4), 
   o_display => o_disp2);

end behave;