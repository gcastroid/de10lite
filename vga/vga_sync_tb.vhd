library ieee;
use ieee.std_logic_1164.all;

entity vga_sync_tb is
end entity;

architecture test of vga_sync_tb is

   signal rst: std_logic;
   signal clk: std_logic;
   signal hor_sync: std_logic;
   signal ver_sync: std_logic;
   signal video_en: std_logic;
   signal hor_count: std_logic_vector(10 downto 0);
   signal ver_count: std_logic_vector(9 downto 0);

   constant t: time := 20 ns;

begin

   dut: entity work.vga_sync 
   port map (
   i_rst => rst, 
   i_clk => clk, 
   o_hor_sync => hor_sync, 
   o_ver_sync => ver_sync, 
   o_video_en => video_en, 
   o_hor_count => hor_count, 
   o_ver_count => ver_count);

   process
   begin
      clk <= '0';
      wait for t/2;
      clk <= '1';
      wait for t/2;
   end process;

   process 
   begin
      rst <= '0';
      wait for t;
      rst <= '1';
      wait;
   end process;

end test;