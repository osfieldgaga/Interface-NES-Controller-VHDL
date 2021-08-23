library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

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
					clk_temp <= (not clk_temp);
				else
						cnt <= cnt - 1;
				end if;
		end if;
	end process;
	
	clk_r <= clk_temp;

end Behavioral;

