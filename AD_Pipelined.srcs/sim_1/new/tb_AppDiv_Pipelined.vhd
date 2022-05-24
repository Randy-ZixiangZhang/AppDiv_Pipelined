--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:35:55 04/10/2022
-- Design Name:   
-- Module Name:   /home/randy/Documents/Forschungspraxis/Curve_Fitting_Method/Approximate_Divider/tb_combinational_unit.vhd
-- Project Name:  Approximate_Divider
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparision_unit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- unsigned for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_AppDiv_Pipelined IS
END tb_AppDiv_Pipelined;
 
ARCHITECTURE behavior OF tb_AppDiv_Pipelined IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
   --Inputs
   signal CLK: std_logic;
   signal RESET: std_logic;
   signal N_a : unsigned(15 downto 0);
   signal N_b : unsigned(15 downto 0);


 	--Outputs
   signal Q: unsigned (27 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
    constant C_CLK :time := 20 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.AppDiv_pipelined PORT MAP (
            Dividend => N_a,
            Divisor => N_b,
            Clk => CLK,
            Reset => RESET,
            Quotient => Q
        );
        
   ClockGenerator: Process
   begin 
        CLK <= '0' after C_CLK, '1' after 2*C_CLK;
        wait for 2*C_CLK;
   end process; 
       
    RESET <= '0';
 	N_a <= "0000010111000000";
	N_b <= "0000000011010000";

END;