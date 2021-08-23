----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:50 08/17/2021 
-- Design Name: 
-- Module Name:    shift_reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_reg is

	port (
		clk, D, en_shift, clear : in std_logic;
		Q : out std_logic_vector (7 downto 0)
	);

end shift_reg;

architecture Behavioral of shift_reg is

	signal q_sig : std_logic_vector(7 downto 0) := "00000000";

begin

	process(clk)
	begin

		if(rising_edge(clk)) then
			if(en_shift ='1') then
				q_sig <= q_sig(6 downto 0) & d;
			elsif(clear = '1') then
				q_sig <= "00000000";
			end if;
		end if;
	end process;

	q <= q_sig;
	
end Behavioral;

