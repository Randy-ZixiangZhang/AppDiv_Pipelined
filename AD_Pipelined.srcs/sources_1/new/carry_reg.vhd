
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity carry_reg is 
    port(CLK,RESET: in std_logic;
        D: in std_logic;
        Q: out std_logic);

end carry_reg;

architecture behavior of carry_reg is

begin
    process(CLK,RESET)
        begin
            if RESET = '1' then
                Q <= '0';
            elsif CLK = '1' and CLK'event then
                Q <= D;
            end if;
        end process;

end behavior;
        

