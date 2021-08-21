library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx_tb is
end entity;

architecture test of uart_tx_tb is

   signal rst: std_logic;
   signal clk: std_logic;
   signal uart_te: std_logic;
   signal byte_tx: std_logic_vector(7 downto 0);
   signal uart_tb: std_logic;
   signal uart_tc: std_logic;
   signal uart_tx: std_logic;

   constant t: time := 20 ns;

begin

   dut: entity work.uart_tx 
   port map(
   i_rst => rst, 
   i_clk => clk, 
   i_te => uart_te,
   i_tx => byte_tx,  
   o_tb => uart_tb,
   o_tc => uart_tc,
   o_tx => uart_tx);

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
      uart_te <= '0';
      byte_tx <= x"00";
      wait for 10 us;
      byte_tx <= x"aa";
      wait for 10 us;
      uart_te <= '1';
      wait for 100 us;
      byte_tx <= x"55";
      wait for 10 us;
      uart_te <= '0';
      wait for 10 us;
      uart_te <= '1';
      wait;
   end process;

end test;