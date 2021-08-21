library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity vga is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   o_hor_sync: out std_logic;
   o_ver_sync: out std_logic;
   o_red: out std_logic_vector(3 downto 0);
   o_grn: out std_logic_vector(3 downto 0);
   o_blu: out std_logic_vector(3 downto 0));
end entity;

architecture behave of vga is

   -- Pin assignments
   attribute chip_pin: string;
   attribute chip_pin of i_rst: signal is "b8";
   attribute chip_pin of i_clk: signal is "p11";
   attribute chip_pin of o_hor_sync: signal is "n3";
   attribute chip_pin of o_ver_sync: signal is "n1";
   attribute chip_pin of o_red: signal is "y1, y2, v1, aa1";
   attribute chip_pin of o_grn: signal is "r1, r2, t2, w1";
   attribute chip_pin of o_blu: signal is "n2, p4, t1, p1";

   signal s_video_en: std_logic;
   signal s_hor_count: std_logic_vector(10 downto 0);
   signal s_ver_count: std_logic_vector(9 downto 0);

begin

   sync_generator: vga_sync 
   port map(
   i_rst => i_rst, 
   i_clk => i_clk, 
   o_hor_sync => o_hor_sync, 
   o_ver_sync => o_ver_sync, 
   o_video_en => s_video_en, 
   o_hor_count => s_hor_count, 
   o_ver_count => s_ver_count);

   rbg_generator: vga_rgb 
   port map(
   i_rst => i_rst, 
   i_clk => i_clk, 
   i_video_en => s_video_en, 
   i_hor_count => s_hor_count, 
   i_ver_count => s_ver_count, 
   o_red => o_red, 
   o_grn => o_grn, 
   o_blu => o_blu);

end behave;