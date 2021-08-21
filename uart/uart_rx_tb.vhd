library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx_tb is
end entity;

architecture test of uart_rx_tb is

   signal rst: std_logic;
   signal clk: std_logic;
   signal uart_rx: std_logic;
   signal byte_rx: std_logic_vector(7 downto 0);
   signal data_rc: std_logic;
   signal data_re: std_logic;

   constant baud_time: time := 8.68 us;
   constant t: time := 20 ns;

   procedure uart_send_byte (
      byte_tx: in std_logic_vector(7 downto 0);
      signal o_tx: out std_logic) is 
   begin
      
      o_tx <= '0';
      wait for baud_time;

      for i in 0 to 7 loop
         o_tx <= byte_tx(i);
         wait for baud_time;
      end loop;

      o_tx <= '1';
      wait for baud_time;

   end procedure;

   procedure uart_send_byte_error (
      byte_tx: in std_logic_vector(7 downto 0);
      signal o_tx: out std_logic) is 
   begin
      
      o_tx <= '0';
      wait for baud_time;

      for i in 0 to 7 loop
         o_tx <= byte_tx(i);
         wait for baud_time;
      end loop;

      o_tx <= '0';
      wait for baud_time;
      o_tx <= '1';

   end procedure;

begin

   dut: entity work.uart_rx 
   port map(
   i_rst => rst, 
   i_clk => clk, 
   i_rx => uart_rx,  
   o_rc => data_rc,
   o_re => data_re,
   o_rx => byte_rx);

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
      uart_rx <= '1';
      wait for 10 us;
      wait until falling_edge(clk);
      uart_send_byte(x"aa", uart_rx);
      wait for 10 us;
      wait until falling_edge(clk);
      uart_send_byte(x"55", uart_rx);
      wait for 10 us;
      wait until falling_edge(clk);
      uart_send_byte_error(x"aa", uart_rx);
      wait for 10 us;
      wait until falling_edge(clk);
      uart_send_byte(x"aa", uart_rx);
      wait;
   end process;

end test;