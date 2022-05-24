----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2022 04:01:11 PM
-- Design Name: 
-- Module Name: compara_unit - Behavioral
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

entity comp_unit is
    generic(BIT_WIDTH : integer);
    Port ( Mantissa_Dividend : in unsigned (BIT_WIDTH-1 downto 0);
           Mantissa_Divisor : in unsigned (BIT_WIDTH-1 downto 0);
           Carry : out STD_LOGIC);
end comp_unit;

architecture Behavioral of comp_unit is


begin
    process(Mantissa_Dividend,Mantissa_Divisor)
    begin
        if Mantissa_Dividend >= Mantissa_Divisor then
            Carry <= '0';
        else 
            Carry <= '1';
        end if;
    end process;
end Behavioral;
