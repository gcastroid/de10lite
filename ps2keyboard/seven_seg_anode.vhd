--
-- Seven segment display decoder (Common anode)
--
--    o_display => 6 5 4 3 2 1 0
-- display leds => g f e d c b a
--

library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_anode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(6 downto 0));
end entity;

architecture behave of seven_seg_anode is 

begin 

process(i_binary)
begin
	case i_binary is 
		when "0000" => o_display <= "1000000";
		when "0001" => o_display <= "1111001";
		when "0010" => o_display <= "0100100";
		when "0011" => o_display <= "0110000";
		when "0100" => o_display <= "0011001";
		when "0101" => o_display <= "0010010";
		when "0110" => o_display <= "0000010";
		when "0111" => o_display <= "1111000";
		when "1000" => o_display <= "0000000";
		when "1001" => o_display <= "0010000";
		when "1010" => o_display <= "0001000";
		when "1011" => o_display <= "0000011";
		when "1100" => o_display <= "1000110";
		when "1101" => o_display <= "0100001";
		when "1110" => o_display <= "0000110";
		when "1111" => o_display <= "0001110";
		when others => o_display <= "1111111";
	end case;
end process;

end behave;
