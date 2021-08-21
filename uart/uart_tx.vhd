library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic;
   i_te: in std_logic;
   i_tx: in std_logic_vector(7 downto 0);
   o_tb: out std_logic;
   o_tc: out std_logic;
   o_tx: out std_logic);
end entity;

architecture behave of uart_tx is

   type st_uart_tx_fsm is (
   st_idle,
   st_start,
   st_data,
   st_stop,
   st_end);
   signal fsm_uart_tx: st_uart_tx_fsm;

   -- baud counter = Fclk/baud
   -- baud counter = 50Mhz/115200
   constant c_baud_count: integer := 434;

   signal r_data_tx: std_logic_vector(7 downto 0);
   signal r_tb: std_logic;
   signal r_tc: std_logic;
   signal r_tx: std_logic;
   signal r_data_bit: integer range 0 to 7;
   signal r_baud_count: integer range 0 to c_baud_count - 1;

begin

   -- uart rx fsm
   process(i_rst, i_clk)
   begin
      if (i_rst = '0') then
         fsm_uart_tx <= st_idle;
         r_data_tx <= (others => '0');
         r_tb <= '0';
         r_tc <= '0';
         r_tx <= '1';
         r_data_bit <= 0;
         r_baud_count <= 0;
      elsif (rising_edge(i_clk)) then
         case fsm_uart_tx is 

            -- idle state
            when st_idle =>

               if (i_te = '1') then
                  r_data_tx <= i_tx;
                  fsm_uart_tx <= st_start;
               else
                  fsm_uart_tx <= st_idle;
               end if;

            -- start bit state
            when st_start =>

               r_tc <= '0';
               r_tb <= '1';
               r_tx <= '0';
               if (r_baud_count < c_baud_count - 1) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_tx <= st_start;
               else 
                  r_baud_count <= 0;
                  fsm_uart_tx <= st_data;
               end if;

            -- data bits state
            when st_data =>

               r_tx <= r_data_tx(r_data_bit);
               if (r_baud_count < c_baud_count - 1) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_tx <= st_data;
               else 
                  r_baud_count <= 0;
                  if (r_data_bit < 7) then
                     r_data_bit <= r_data_bit + 1;
                     fsm_uart_tx <= st_data;
                  else
                     r_data_bit <= 0;
                     fsm_uart_tx <= st_stop;
                  end if;
               end if;

            -- stop bit state 
            when st_stop => 

               r_tx <= '1';
               if (r_baud_count < c_baud_count - 1) then
                  r_baud_count <= r_baud_count + 1;
                  fsm_uart_tx <= st_stop;
               else 
                  r_baud_count <= 0;
                  r_tc <= '1';
                  fsm_uart_tx <= st_end;
               end if;

            -- end of rx state
            when st_end => 

               r_tb <= '0';
               if (i_te = '1') then
                  fsm_uart_tx <= st_end;
               else
                  fsm_uart_tx <= st_idle;
               end if;
              
         end case;
      end if;
   end process;

   o_tb <= r_tb;
   o_tc <= r_tc;
   o_tx <= r_tx;

end behave;