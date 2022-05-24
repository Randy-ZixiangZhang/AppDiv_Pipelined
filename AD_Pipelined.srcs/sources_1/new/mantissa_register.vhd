
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity mantissa_register is 
    generic( BIT_WIDTH : integer);
    port(CLK,RESET: in bit;
        D: in unsigned (BIT_WIDTH - 1 downto 0);
        Q: out unsigned (BIT_WIDTH - 1 downto 0));

end mantissa_register;

architecture behavior of mantissa_register is

begin
    process(CLK,RESET)
        begin
            if RESET = '1' then
                Q <= (others => '0');
            elsif CLK = '1' and CLK'event then
                Q <= D;
            end if;
        end process;

end behavior;
        

