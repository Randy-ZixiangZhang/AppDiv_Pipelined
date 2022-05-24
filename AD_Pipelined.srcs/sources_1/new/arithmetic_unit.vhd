----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2022 04:23:59 PM
-- Design Name: 
-- Module Name: shift_back_unit - Behavioral
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

entity arithmetic_unit is
    generic( BIT_WIDTH : integer);
    Port ( 
           Mantissa_Dividend: in unsigned (BIT_WIDTH-1 downto 0);
           Mantissa_Divisor: in unsigned (BIT_WIDTH-1 downto 0);
           data : in  unsigned (35 downto 0);
           Num_shift : in integer range 0 to BIT_WIDTH-1;
           Quotient : out unsigned (BIT_WIDTH-1 + 12 downto 0));
end arithmetic_unit;

architecture Behavioral of arithmetic_unit is




begin

    --process(Mantissa_Dividend,Mantissa_Divisor,P00,P01,P10,Num_shift)
    process
       variable p00:unsigned (11 downto 0);
       variable p01:unsigned (11 downto 0);
       variable p10:unsigned (11 downto 0); 
        
        
       variable tempMUL_1: unsigned(BIT_WIDTH-1 + 12 downto 0);
	   variable tempMUL_2: unsigned(BIT_WIDTH-1 + 12 downto 0);

	   variable temp: unsigned(BIT_WIDTH-1 + 12 downto 0);
       variable app_M: unsigned (BIT_WIDTH-1 + 12 downto 0);
       variable long_p00: unsigned (BIT_WIDTH-1 + 12 downto 0) := (others => '0');
        
       constant offset: integer:= 10; --output radix position - tempMUL radix position
        
        begin
        
        -- has to be aware that 2 bits are used for integer represnetation for each parameter
        
        p00 := data(35 downto 24);
        p01 := data(23 downto 12);
        p10 := data(11 downto 0);
        
            tempMUL_1 := p10*Mantissa_Dividend;
            tempMUL_2 := p01*Mantissa_Divisor;
            
            long_p00((BIT_WIDTH -1 + 12) downto BIT_WIDTH) := p00;
            
            temp := long_p00 + tempMUL_1 - tempMUL_2; -- integer 26 decimal,
            
            app_M := temp;
            
            -- assuming input are 12 integer, 4 bits for decimal
            Quotient <= shift_right(app_M, offset + Num_shift);
        
        

    end process;

end Behavioral;