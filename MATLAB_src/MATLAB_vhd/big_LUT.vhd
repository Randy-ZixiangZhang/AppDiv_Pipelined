library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity big_LUT is
   generic(BIT_WIDTH : integer);
   Port ( carry : in STD_LOGIC;
       Mantissa_Dividend : in unsigned(BIT_WIDTH - 1 downto 0);
       Mantissa_Divisor : in unsigned(BIT_WIDTH - 1 downto 0);
       Addr : out std_logic_vector(8 downto 0)
       );
end big_LUT;

architecture Behavioral of big_LUT is
begin
   process(carry,Mantissa_Dividend,Mantissa_Divisor)
       variable ROM_address:unsigned(8 downto 0):=(others => '0');
       constant m1: unsigned(BIT_WIDTH - 1 downto 0) := "0010101010101010";
       constant m2: unsigned(BIT_WIDTH - 1 downto 0) := "0101010101010101";
       constant m3: unsigned(BIT_WIDTH - 1 downto 0) := "1000000000000000";
       constant m4: unsigned(BIT_WIDTH - 1 downto 0) := "1010101010101010";
       constant m5: unsigned(BIT_WIDTH - 1 downto 0) := "1101010101010101";

       begin
       if carry = '0' then



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



else
if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(21),9);
elsif Mantissa_Divisor < m2 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(22),9);
    else
        ROM_address:= to_unsigned(integer(23),9);
    end if;
elsif Mantissa_Divisor < m3 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(24),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(25),9);
    else
        ROM_address:= to_unsigned(integer(26),9);
    end if;
elsif Mantissa_Divisor < m4 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(27),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(28),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(29),9);
    else
        ROM_address:= to_unsigned(integer(30),9);
    end if;
elsif Mantissa_Divisor < m5 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(31),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(32),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(33),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(34),9);
    else
        ROM_address:= to_unsigned(integer(35),9);
    end if;
else
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(36),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(37),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(38),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(39),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(40),9);
    else
        ROM_address:= to_unsigned(integer(41),9);
    end if;
end if;


end if;


Addr <= std_logic_vector(ROM_address);
end process;
end Behavioral;
