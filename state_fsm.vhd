library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity state_fsm is

	port(
		clk_6, rst : in std_logic;
		--data : in std_logic;
		pulse, latch : out std_logic;
		en_shift, en_reg : out std_logic
		--a, b, sel, start, u, d, l, r : out std_logic
		--led : out std_logic_vector(7 downto 0)
	);
	
end state_fsm;

architecture Behavioral of state_fsm is

	type states is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, ST10, ST11, ST12, ST13, ST14, ST15, ST16, ST17, st18);
	signal ps, ns : states;
	
	--signal cnt2 : integer := 1390;
	signal cnt2 : integer := 2779;
	
	signal s1 : std_logic;
	
	--signal a, b, sel, start, u, d, l, r : std_logic;
	
	--signal led_sig : std_logic_vector(7 downto 0) := "00000000";
	--signal en_shift_ : std_logic;
	
	
	

begin

	
	
	process (clk_6, cnt2)
	begin
		if(rising_edge(clk_6)) then
			
			if(cnt2 <= 0) then ---every 60Hz
				--cnt2 <= 1389;
				cnt2 <= 2779;
				 s1 <= '1';
				 
				 
			else
				cnt2 <= cnt2 - 1;
				s1 <= '0';
			end if;
			
		end if;
	end process;
	
	
	--led <= a & b & sel & start & u & d & l & r;
	
	process (clk_6, rst)
	begin
		if(rst = '1') then
			ps <= st0;
		elsif(rising_edge(clk_6)) then
			ps <= ns;
		end if;
	end process;
	
	
	
	process(ps, s1)
	begin
		case (ps) is
			when st0 =>   ----flat, nothing here
				if (s1 = '1') then
					
					ns <= st1;
					
				else 
					ns <= st0;
				end if;
			
			when st1 =>  --latch on
					ns <= st2;
					
			when st2 => --latch on 2

					ns <= st3;

			
			when st3 => ---button A

					ns <= st4;
			
			
			when st4 => ---button A wait
				
					ns <= st5;
			
			
			when st5 =>  ---button B
				
					ns <= st6;
				
			when st6 =>  ---button B wait
				
					ns <= st7;
				
			
			
			when st7 => --- button SELECT
			
					ns <= st8;
			
			when st8 => --- button SELECT wait
				
					ns <= st9;
			
			
			when st9 => --- button START
			
					ns <= st10;
				
			when st10 => --- button START wait
				
					ns <= st11;
				
			
			
			when st11 => --- button UP
					ns <= st12;
		
			when st12 => --- button UP wait
				
					ns <= st13;
			
			
			when st13 => --- button DOWN
			
					ns <= st14;
				
			when st14 => --- button DOWN wait
				
					ns <= st15;
				
			
			when st15 => --- button LEFT
				
					ns <= st16;
				
			
			when st16 => --- button LEFT wait
			
					ns <= st17;
			
			
			
			when st17 => --- button RIGHT
				
					ns <= st18;
					
					
			when st18 => --- button RIGHT
				
					ns <= st0;
			
			
		end case;
	end process;
	
	
	--led <= led_sig(6 downto 0) & (not data) when en_shift = '1';
	
	process (ps)
	begin
		case (ps) is
			when st0 =>
				latch <= '0';
				pulse <= '0';
				
				--a <= '0';
				--b <= '0';
				--sel <= '0';
				--start <= '0';
				--u <= '0';
				--d <= '0';
				--l <= '0';
				--r <= '0';
				
				
				en_shift <= '0';
				en_reg <= '0';
			
			when st1 => 
				latch <= '1';
				pulse <= '0';
				
				
				
				en_shift <= '0';
				en_reg <= '0';
				
			when st2 => 
				latch <= '1';
				pulse <= '0';
				
				
				en_shift <= '1';
				en_reg <= '0';
				
			when st3 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
				
				---- B
			when st4 => 
				latch <= '0';
				pulse <= '1';
				
				en_shift <= '1';
				en_reg <= '0';
			
			when st5 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				
				en_reg <= '0';
			
			---SEL
			when st6 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '1';
				en_reg <= '0';
			
			when st7 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
				
				----START
			when st8 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '1';
				en_reg <= '0';
			
			when st9 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
			
				----UP
			when st10 => 
				latch <= '0';
				pulse <= '1';
				
				en_shift <= '1';
				en_reg <= '0';
			
			when st11 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
			
				--DOWN
			when st12 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '1';
				en_reg <= '0';
			
			when st13 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
			
				---LEFT
			when st14 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '1';
				en_reg <= '0';
			
			when st15 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
			
				---RIGHT
			when st16 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '1';
				en_reg <= '0';
				 
				
			when st17 => 
				latch <= '0';
				pulse <= '0';

				en_shift <= '0';
				en_reg <= '0';
			
				---NOTHING
			when st18 => 
				latch <= '0';
				pulse <= '1';

				en_shift <= '0';
				en_reg <= '1';
			
				
				
		end case;
	end process;


end Behavioral;

