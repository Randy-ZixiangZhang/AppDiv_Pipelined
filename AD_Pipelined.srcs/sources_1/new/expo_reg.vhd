
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity expo_reg is 
    generic( BIT_WIDTH : integer);
    port(CLK,RESET: in std_logic;
        D: in integer range 0 to BIT_WIDTH - 1;
        Q: out integer range 0 to BIT_WIDTH - 1);
end expo_reg;

architecture behavior of expo_reg is

begin
    process(CLK,RESET)
        begin
            if RESET = '1' then
                Q <= 0;
            elsif CLK = '1' and CLK'event then
                Q <= D;
            end if;
        end process;

end behavior;
        

