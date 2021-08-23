library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_2 is

	port(
		clk_50m, rst, data : in std_logic;
		pulse, latch, pulse_osc, latch_osc, data_out : out std_logic;
		--a, b, sel, start, u, d, l, r : out std_logic
		led : out std_logic_vector(7 downto 0)
	);

end main_2;

architecture Behavioral of main_2 is

	component clk_6us

		port(
			clk : in std_logic;
			clk_r : out std_logic
		);

	end component;
	
	component state_fsm

		port(
			clk_6, rst : in std_logic;
			pulse, latch, en_shift, en_reg : out std_logic
		);
	
	end component;
	
	component shift_reg

		port (
			clk, D, en_shift, clear : in std_logic;
			Q : out std_logic_vector (7 downto 0)
		);

	end component;
	
	component dff

		port(
				clk, load, clear: in std_logic;
					  D : in std_logic_vector (7 downto 0);
					  Q : out std_logic_vector (7 downto 0)
		);

	end component;

	signal clk_6u_sig, pulse_sig ,latch_sig : std_logic;
	
	signal en_shift_sig, en_reg_sig : std_logic;
	signal shift_out : std_logic_vector (7 downto 0);
	
begin

	data_out <= data;

	shift_reg1 : shift_reg port map (
		clk => clk_6u_sig,
		d => data,
		clear => en_reg_sig,
		en_shift => en_shift_sig,
		Q => shift_out
	);
	
	dff1 : dff port map (
		clk => clk_6u_sig,
		load => en_reg_sig,
		clear => '0',
		D => shift_out,
		Q => led
	);

	pulse <= pulse_sig;
	latch <= latch_sig;
	
	pulse_osc <= pulse_sig;
	latch_osc <= latch_sig;

	fsm : state_fsm port map (
		rst => rst,
		clk_6 => clk_6u_sig,
		pulse => pulse_sig,
		latch => latch_sig,
		
		en_shift => en_shift_sig,
		en_reg => en_reg_sig
	);

	clock_6us : clk_6us port map (
		clk => clk_50m,
		clk_r => clk_6u_sig
	);


end Behavioral;

