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
use IEEE.std_logic_textio.all; 
library std;
     use std.textio.all; 
 
ENTITY tb_AppDiv_Pipelined_automated IS
END tb_AppDiv_Pipelined_automated;
 
ARCHITECTURE behavior OF tb_AppDiv_Pipelined_automated IS 
 
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
    constant C_CLK :time := 10 ns;
    constant Data_in:string := "/home/randy/Documents/AD_Pipelined/MATLAB_src/Simulation_related_txt/DataIn.txt";
    constant Data_out:string := "/home/randy/Documents/AD_Pipelined/MATLAB_src/Simulation_related_txt/DataOut.txt";
    file fptr: text;
    file fptr_out: text;  
    
    --write 
    file w_file:text; 
    
    signal flag_done:boolean := false;
    constant C_DATA1_W   :integer := 16;
    constant C_DATA2_W   :integer := 16;
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

    GetData_proc: process
        variable clock_count:integer:= 0;
        
        variable fstatus:file_open_status;
        variable file_line     :line;
        variable var_data1     :integer;
        variable var_data2     :integer;
        variable good1:boolean;
        variable good2:boolean;
        
        variable w_file_is_open: boolean;
        variable trace_line : line;
    begin
        file_open(fptr,Data_in,READ_MODE);
        file_open(fstatus,w_file,Data_out,WRITE_MODE);
    
        while (not endfile(fptr)) loop
            wait until CLK = '1';
            
            readline(fptr,file_line);
            read(file_line, var_data1,good1);
            read(file_line, var_data2,good2);     
    
            N_a <= shift_left(to_unsigned(var_data1,C_DATA1_W),4);
            N_b <= shift_left(to_unsigned(var_data2,C_DATA1_W),4);
            clock_count := clock_count + 1;
            
            if clock_count >= 4 then
                wait for 5ns;
                write(trace_line,std_logic_vector(Q));
                writeline(w_file,trace_line);
            end if;
         end loop; 
         
        wait  until rising_edge(clk);
            flag_done <= true;
            file_close(fptr);  
            file_close(fptr_out); 
        wait;
         
    end process;
end;