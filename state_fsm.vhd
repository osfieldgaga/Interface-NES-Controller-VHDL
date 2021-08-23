library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity state_fsm is

	port(
		clk_6, rst : in std_logic;
		pulse, latch : out std_logic;
		en_shift, en_reg : out std_logic

	);
	
end state_fsm;

architecture Behavioral of state_fsm is

	type states is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, ST10, ST11, ST12, ST13, ST14, ST15, ST16, ST17, st18);
	signal ps, ns : states;
	
	signal cnt2 : integer := 2779;
	
	signal s1 : std_logic;

begin

	
	
	process (clk_6, cnt2)
	begin
		if(rising_edge(clk_6)) then
			
			if(cnt2 <= 0) then ---every 60Hz
			--60Hz is apprx. 2780 times slower then 166.67kHz (6us)
				cnt2 <= 2779;
				 s1 <= '1'; --to control when to begin with the latch signal
			else
				cnt2 <= cnt2 - 1;
				s1 <= '0';
			end if;
			
		end if;
	end process;

	
	state_register : process (clk_6, rst)
	begin
		if(rst = '1') then
			ps <= st0;
		elsif(rising_edge(clk_6)) then
			ps <= ns;
		end if;
	end process;
	
	
	
	compute_ns : process(ps, s1)
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

			
			when st3 => 

					ns <= st4;
			
			
			when st4 => 
				
					ns <= st5;
			
			
			when st5 => 
				
					ns <= st6;
				
			when st6 => 
				
					ns <= st7;
				
			
			
			when st7 => 
			
					ns <= st8;
			
			when st8 =>
				
					ns <= st9;
			
			
			when st9 =>
			
					ns <= st10;
				
			when st10 =>
				
					ns <= st11;
				
			
			
			when st11 =>
					ns <= st12;
		
			when st12 =>
				
					ns <= st13;
			
			
			when st13 => 
			
					ns <= st14;
				
			when st14 =>
				
					ns <= st15;
				
			
			when st15 =>
				
					ns <= st16;
				
			
			when st16 =>
			
					ns <= st17;
			
			
			
			when st17 =>
				
					ns <= st18;
					
					
			when st18 =>
				
					ns <= st0;
			
			
		end case;
	end process;
	
	
	generate_waveforms : process (ps)
	begin
		case (ps) is
			when st0 =>
				latch <= '0';
				pulse <= '0';
				
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

