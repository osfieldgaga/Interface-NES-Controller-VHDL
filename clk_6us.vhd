----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:23:34 08/13/2021 
-- Design Name: 
-- Module Name:    clk_12us - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_6us is

	port(
		clk : in std_logic;
		clk_r : out std_logic
	);

end clk_6us;

architecture Behavioral of clk_6us is

	signal cnt : integer := 0;
	signal clk_temp : std_logic := '0';

begin

	process (clk)
	begin
		if(rising_edge(clk)) then
				if (cnt <= 0) then
					cnt <= 149;
						--cnt <= 299;
					clk_temp <= (not clk_temp);
				else
						cnt <= cnt - 1;
				end if;
		end if;
	end process;
	
	clk_r <= clk_temp;

end Behavioral;

