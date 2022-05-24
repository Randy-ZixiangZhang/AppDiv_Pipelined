----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2022 08:39:35 AM
-- Design Name: 
-- Module Name: shift_unit - Behavioral
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
--use IEEE.fixed_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- The purpose of shift unit is to get mantissa of the given number (dividend or divisor)
-- In other words, remove the leading zero and shift the n

entity shift_unit is
    generic( BIT_WIDTH : integer);
    Port ( N : in unsigned (BIT_WIDTH - 1 downto 0);
           Exp : out integer range 0 to BIT_WIDTH - 1;
           N_s : out unsigned (BIT_WIDTH - 1 downto 0));
end shift_unit;

architecture Behavioral of shift_unit is

begin

 process(N)
    variable index_msb_N: integer range -1 to BIT_WIDTH - 1:= -1;
    --constant bit_mask:unsigned (BIT_WIDTH - 1 downto 0):= ((BIT_WIDTH - 1) downto (BIT_WIDTH - 1 - INTS) => '0', others => '1');--(others => '1');
    
    begin 
        for i in BIT_WIDTH - 1 downto 0 loop
            if N(i) = '1' then
                index_msb_N:= i;
                Exp <= index_msb_N;
                N_s <= shift_left(N, BIT_WIDTH - index_msb_N); --shift to remove the MSB --and bit_mask;
                exit;
            else
                next;
            end if;
        end loop;
    
	end process;

-- possible future improvement:
-- handling of zero input

end Behavioral;