library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_rgb is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_video_en: in std_logic;
   i_hor_count: in std_logic_vector(10 downto 0);
   i_ver_count: in std_logic_vector(9 downto 0);
   o_red: out std_logic_vector(3 downto 0);
   o_grn: out std_logic_vector(3 downto 0);
   o_blu: out std_logic_vector(3 downto 0));
end entity;

architecture behave of vga_rgb is

   -- RBG Pixel signals
   signal s_red: std_logic_vector(3 downto 0);
   signal s_grn: std_logic_vector(3 downto 0);
   signal s_blu: std_logic_vector(3 downto 0);
   signal r_red: std_logic_vector(3 downto 0);
   signal r_grn: std_logic_vector(3 downto 0);
   signal r_blu: std_logic_vector(3 downto 0);

begin

   -- RGB logic
   s_red <= 
   "1111" when to_integer(unsigned(i_hor_count)) <= 70 else 
   "1001" when to_integer(unsigned(i_hor_count)) > 70 and to_integer(unsigned(i_hor_count)) <= 170 else
   "0110" when to_integer(unsigned(i_hor_count)) > 170 and to_integer(unsigned(i_hor_count)) <= 250 else
   "0100" when to_integer(unsigned(i_hor_count)) > 250 and to_integer(unsigned(i_hor_count)) <= 300 else
   "0011" when to_integer(unsigned(i_hor_count)) > 300 and to_integer(unsigned(i_hor_count)) <= 500 else
   "0010" when to_integer(unsigned(i_hor_count)) > 500 and to_integer(unsigned(i_hor_count)) <= 700 else
   (others => '0');

   s_grn <= 
   "1110" when to_integer(unsigned(i_hor_count)) <= 50 else 
   "1011" when to_integer(unsigned(i_hor_count)) > 50 and to_integer(unsigned(i_hor_count)) <= 100 else
   "0101" when to_integer(unsigned(i_hor_count)) > 100 and to_integer(unsigned(i_hor_count)) <= 200 else
   "0011" when to_integer(unsigned(i_hor_count)) > 200 and to_integer(unsigned(i_hor_count)) <= 400 else
   "0010" when to_integer(unsigned(i_hor_count)) > 400 and to_integer(unsigned(i_hor_count)) <= 600 else
   (others => '0');

   s_blu <= 
   "1111" when to_integer(unsigned(i_ver_count)) <= 80 else 
   "1100" when to_integer(unsigned(i_ver_count)) > 80 and to_integer(unsigned(i_ver_count)) <= 140 else
   "1001" when to_integer(unsigned(i_ver_count)) > 140 and to_integer(unsigned(i_ver_count)) <= 220 else
   "0110" when to_integer(unsigned(i_ver_count)) > 220 and to_integer(unsigned(i_ver_count)) <= 300 else
   "0011" when to_integer(unsigned(i_ver_count)) > 300 and to_integer(unsigned(i_ver_count)) <= 380 else
   "0010" when to_integer(unsigned(i_ver_count)) > 380 and to_integer(unsigned(i_ver_count)) <= 490 else
   (others => '0');

   -- Register the RGB signals
   process(i_rst, i_clk) 
   begin
      if (i_rst = '0') then
         r_red <= (others => '0');
         r_grn <= (others => '0');
         r_blu <= (others => '0');
      elsif (rising_edge(i_clk)) then
         r_red <= s_red;
         r_grn <= s_grn;
         r_blu <= s_blu;
      end if;
   end process;

   -- Output RBG signals
   o_red <= r_red when i_video_en = '1' else (others => '0');
   o_grn <= r_grn when i_video_en = '1' else (others => '0');
   o_blu <= r_blu when i_video_en = '1' else (others => '0');

end behave;