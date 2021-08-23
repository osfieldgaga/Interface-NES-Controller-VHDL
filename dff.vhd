library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity dff is

	port(
			clk, load, clear: in std_logic;
				  D : in std_logic_vector (7 downto 0);
				  Q : out std_logic_vector (7 downto 0)
	);

end dff;

architecture Behavioral of dff is

begin
		process(clk, clear)
			begin
				if(rising_edge(clk)) then
					if load = '1' then
						Q <= D;
					elsif (clear = '1') then
						Q <= "00000000";
					end if;
				end if;
			end process;

end Behavioral;

