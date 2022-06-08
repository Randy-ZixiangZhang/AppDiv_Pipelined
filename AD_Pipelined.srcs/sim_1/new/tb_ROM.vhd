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
       
   --signal Mantissa_Dividend: unsigned(15 downto 0);
   --signal Mantissa_Divisor: unsigned(15 downto 0);     
       
   
begin

       
    MYMEM: entity work.AppDiv_ROM
                port map(CLK,address,DATA);
                
   ClockGenerator: Process
   begin 
        CLK <= '0' after C_CLK, '1' after 2*C_CLK;
        wait for 2*C_CLK;
   end process;    
   

   process(CLK)
       variable ROM_address:unsigned(8 downto 0):=(others => '0');
       variable Mantissa_Dividend: unsigned(15 downto 0);
       variable Mantissa_Divisor: unsigned(15 downto 0);
       
       
       constant m1: unsigned(15 downto 0) := "0010101010101010";
       constant m2: unsigned(15 downto 0) := "0101010101010101";
       constant m3: unsigned(15 downto 0) := "1000000000000000";
       constant m4: unsigned(15 downto 0) := "1010101010101010";
       constant m5: unsigned(15 downto 0) := "1101010101010101";
   begin
    
    
    -- Original dividend and divisor see tb_AppDiv
    Mantissa_Dividend := "1000111000000000";-- "1001011111010110" after 70ns,"0011011111010110" after 100ns;
	Mantissa_Divisor := "0000011000000000";-- "0001000101001111" after 70ns,"0001011111010110" after 100ns;


    if Mantissa_Dividend < m1 then
            ROM_address:= to_unsigned(integer(0),9);
    elsif Mantissa_Dividend < m2 then
        if Mantissa_Divisor < m1 then
            ROM_address:= to_unsigned(integer(1),9);
        else
            ROM_address:= to_unsigned(integer(2),9);
        end if;
    elsif Mantissa_Dividend < m3 then
        if Mantissa_Divisor < m1 then
            ROM_address:= to_unsigned(integer(3),9);
        elsif Mantissa_Divisor < m2 then
            ROM_address:= to_unsigned(integer(4),9);
        else
            ROM_address:= to_unsigned(integer(5),9);
        end if;
    elsif Mantissa_Dividend < m4 then
        if Mantissa_Divisor < m1 then
            ROM_address:= to_unsigned(integer(6),9);
        elsif Mantissa_Divisor < m2 then
            ROM_address:= to_unsigned(integer(7),9);
        elsif Mantissa_Divisor < m3 then
            ROM_address:= to_unsigned(integer(8),9);
        else
            ROM_address:= to_unsigned(integer(9),9);
        end if;
    elsif Mantissa_Dividend < m5 then
        if Mantissa_Divisor < m1 then
            ROM_address:= to_unsigned(integer(10),9);
        elsif Mantissa_Divisor < m2 then
            ROM_address:= to_unsigned(integer(11),9);
        elsif Mantissa_Divisor < m3 then
            ROM_address:= to_unsigned(integer(12),9);
        elsif Mantissa_Divisor < m4 then
            ROM_address:= to_unsigned(integer(13),9);
        else
            ROM_address:= to_unsigned(integer(14),9);
        end if;
    else
        if Mantissa_Divisor < m1 then
            ROM_address:= to_unsigned(integer(15),9);
        elsif Mantissa_Divisor < m2 then
            ROM_address:= to_unsigned(integer(16),9);
        elsif Mantissa_Divisor < m3 then
            ROM_address:= to_unsigned(integer(17),9);
        elsif Mantissa_Divisor < m4 then
            ROM_address:= to_unsigned(integer(18),9);
        elsif Mantissa_Divisor < m5 then
            ROM_address:= to_unsigned(integer(19),9);
        else
            ROM_address:= to_unsigned(integer(20),9);
        end if;
    end if;
    
             
    address <= std_logic_vector(ROM_address);
   end process;
             
end Behavioral;
