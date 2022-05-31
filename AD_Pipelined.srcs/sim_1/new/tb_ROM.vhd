----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 04:55:43 AM
-- Design Name: 
-- Module Name: tb_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ROM is
--  Port ( );
end tb_ROM;

architecture Behavioral of tb_ROM is
   signal CLK: std_logic;

   signal address : std_logic_vector(8 downto 0);

 	--Outputs
   signal DATA: unsigned (35 downto 0);
       constant C_CLK :time := 20 ns;
   
begin

       
    MYMEM: entity work.AppDiv_ROM
                port map(CLK,address,DATA);
                
   ClockGenerator: Process
   begin 
        CLK <= '0' after C_CLK, '1' after 2*C_CLK;
        wait for 2*C_CLK;
   end process;    
             
    address <= "000000000", "000000001" after 70ns;
        
             
end Behavioral;
