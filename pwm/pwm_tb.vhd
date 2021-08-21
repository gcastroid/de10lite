library ieee;
use ieee.std_logic_1164.all;

entity pwm_tb is
end entity;

architecture test of pwm_tb is

   signal rst: std_logic;
   signal clk: std_logic;
   signal prescaler: std_logic;
   signal duty: std_logic_vector(9 downto 0);
   signal disp: std_logic_vector(6 downto 0);
   signal pwm: std_logic;

   constant t: time := 20 ns;

begin

   dut: entity work.pwm 
   port map(
   i_rst => rst, 
   i_clk => clk, 
   i_prescaler => prescaler, 
   i_duty => duty, 
   o_disp1 => disp,
   o_pwm => pwm);

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

   process
   begin
      prescaler <= '1';
      wait for 1 ms;
      prescaler <= '0';
      wait for 1 us;
      prescaler <= '1';
      wait for 1 ms;
      prescaler <= '0';
      wait for 1 us;
      prescaler <= '1';
      wait for 1 ms;
      prescaler <= '0';
      wait for 1 us;
      prescaler <= '1';
      wait for 1 ms;
      prescaler <= '0';
      wait for 1 us;
      prescaler <= '1';
      wait;
   end process;

   process
   begin 
      duty <= "0100000000";
      wait for 6 ms;
      duty <= "1000000000";
      wait for 2 ms;
      duty <= "1100000000";
      wait;
   end process;

end test;