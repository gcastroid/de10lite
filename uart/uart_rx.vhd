library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity uart_rx is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_rx: in std_logic;
   o_rc: out std_logic;
   o_re: out std_logic;
   o_rx: out std_logic_vector(7 downto 0));
end entity;

architecture behave of uart_rx is

   type st_uart_rx_fsm is (
   st_idle,
   st_start,
   st_data,
   st_stop,
   st_error,
   st_end);
   signal fsm_uart_rx: st_uart_rx_fsm;

   -- baud counter = Fclk/baud
   -- baud counter = 50Mhz/115200
   constant c_baud_count: integer := 434;

   signal r_data_rx: std_logic_vector(7 downto 0);
   signal r_rx: std_logic_vector(7 downto 0);
   signal r_rc: std_logic;
   signal r_re: std_logic;
   signal r_en: std_logic;
   signal r_data_bit: integer range 0 to 7;
   signal r_baud_count: integer range 0 to c_baud_count - 1;

begin

   -- uart rx fsm
   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         fsm_uart_rx <= st_idle;
         r_data_rx <= (others => '0');
         r_rc <= '0';
         r_re <= '0';
         r_data_bit <= 0;
         r_baud_count <= 0;
      elsif (rising_edge(i_clk)) then
         case fsm_uart_rx is 

            -- idle state
            when st_idle =>

               if (i_rx = '0') then
                  fsm_uart_rx <= st_start;
               else
                  fsm_uart_rx <= st_idle;
               end if;

            -- start bit state
            when st_start =>

               if (r_baud_count < c_baud_count / 2) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_rx <= st_start;
               else 
                  r_baud_count <= 0;
                  if (i_rx = '0') then
                     fsm_uart_rx <= st_data;
                  else 
                     fsm_uart_rx <= st_idle;
                  end if;
               end if;

            -- data bits state
            when st_data =>

               r_rc <= '0';
               r_re <= '0';
               if (r_baud_count < c_baud_count - 1) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_rx <= st_data;
               else 
                  r_baud_count <= 0;
                  r_data_rx(r_data_bit) <= i_rx;
                  if (r_data_bit < 7) then
                     r_data_bit <= r_data_bit + 1;
                     fsm_uart_rx <= st_data;
                  else
                     r_data_bit <= 0;
                     fsm_uart_rx <= st_stop;
                  end if;
               end if;

            -- stop bit state 
            when st_stop => 

               if (r_baud_count < c_baud_count - 1) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_rx <= st_stop;
               else
                  r_baud_count <= 0;
                  if (i_rx = '1') then
                     r_en <= '1';
                     fsm_uart_rx <= st_end;
                  else 
                     fsm_uart_rx <= st_error;
                  end if;
               end if;

            -- error state
            when st_error => 

               if (r_baud_count < c_baud_count / 2) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_rx <= st_error;
               else 
                  r_baud_count <= 0;
                  r_re <= '1';
                  fsm_uart_rx <= st_idle;
               end if;  

            -- end of rx state
            when st_end => 

               if (r_baud_count < c_baud_count / 2) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_rx <= st_end;
               else 
                  r_baud_count <= 0;
                  r_en <= '0';
                  r_rc <= '1';
                  fsm_uart_rx <= st_idle;
               end if;  
              
         end case;
      end if;
   end process;

   reg1: reg
   generic map(8)
   port map(
   i_rst => i_rst,
   i_clk => i_clk,
   i_en => r_en,
   i_data => r_data_rx,   
   o_data => r_rx);

   o_rx <= r_rx;
   o_rc <= r_rc;
   o_re <= r_re;

end behave;