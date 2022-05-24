
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity data_reg is 
    port(CLK,RESET: in std_logic;
        D: in unsigned(35 downto 0);
        Q: out unsigned(35 downto 0));
end data_reg;

architecture behavior of data_reg is

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
        

