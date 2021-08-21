library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sync is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   o_hor_sync: out std_logic;
   o_ver_sync: out std_logic;
   o_video_en: out std_logic;
   o_hor_count: out std_logic_vector(10 downto 0);
   o_ver_count: out std_logic_vector(9 downto 0));
end entity;

architecture behave of vga_sync is

   -- Horizontal values
   constant c_hor_active: integer := 800;
   constant c_hor_fporch: integer := 856;
   constant c_hor_spulse: integer := 976;
   constant c_hor_wline: integer := 1040;
   -- Vertical values
   constant c_ver_active: integer := 600;
   constant c_ver_fporch: integer := 637;
   constant c_ver_spulse: integer := 643;
   constant c_ver_wframe: integer := 666;
   -- Counters
   signal s_hor_count: integer range 0 to c_hor_wline-1;
   signal s_ver_count: integer range 0 to c_ver_wframe-1;
   -- Display area signals
   signal s_hor_disp: std_logic;
   signal s_ver_disp: std_logic;

begin

   -- Horizontal and Vertical Counters
   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         s_hor_count <= 0;
         s_ver_count <= 0;
      elsif (rising_edge(i_clk)) then
         if (s_hor_count = c_hor_wline-1) then
            if (s_ver_count = c_ver_wframe-1) then
               s_ver_count <= 0;
            else
               s_ver_count <= s_ver_count + 1;
            end if;
            s_hor_count <= 0;
         else 
            s_hor_count <= s_hor_count + 1;
         end if;
      end if;
   end process;

   -- Horizontal and Vertical counters outputs
   o_hor_count <= std_logic_vector(to_unsigned(s_hor_count, o_hor_count'length));
   o_ver_count <= std_logic_vector(to_unsigned(s_ver_count, o_ver_count'length));

   -- Display area enable
   s_hor_disp <= '1' when s_hor_count < c_hor_active else '0';
   s_ver_disp <= '1' when s_ver_count < c_ver_active else '0';
   o_video_en <= s_hor_disp and s_ver_disp;

   -- hsync and vsync signals
   o_hor_sync <= '0' when (s_hor_count > c_hor_fporch-1) and (s_hor_count < c_hor_spulse) else '1';
   o_ver_sync <= '0' when (s_ver_count > c_ver_fporch-1) and (s_ver_count < c_ver_spulse) else '1';

end behave;