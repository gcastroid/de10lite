library ieee;
use ieee.std_logic_1164.all;

package components is 

component vga_sync is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   o_hor_sync: out std_logic;
   o_ver_sync: out std_logic;
   o_video_en: out std_logic;
   o_hor_count: out std_logic_vector(10 downto 0);
   o_ver_count: out std_logic_vector(9 downto 0));
end component;

component vga_rgb is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_video_en: in std_logic;
   i_hor_count: in std_logic_vector(10 downto 0);
   i_ver_count: in std_logic_vector(9 downto 0);
   o_red: out std_logic_vector(3 downto 0);
   o_grn: out std_logic_vector(3 downto 0);
   o_blu: out std_logic_vector(3 downto 0));
end component;

end components;