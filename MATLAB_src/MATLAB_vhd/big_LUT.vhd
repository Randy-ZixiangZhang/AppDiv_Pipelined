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
       constant m1: unsigned(BIT_WIDTH - 1 downto 0) := "0001100110011001";
       constant m2: unsigned(BIT_WIDTH - 1 downto 0) := "0011001100110011";
       constant m3: unsigned(BIT_WIDTH - 1 downto 0) := "0100110011001100";
       constant m4: unsigned(BIT_WIDTH - 1 downto 0) := "0110011001100110";
       constant m5: unsigned(BIT_WIDTH - 1 downto 0) := "1000000000000000";
       constant m6: unsigned(BIT_WIDTH - 1 downto 0) := "1001100110011001";
       constant m7: unsigned(BIT_WIDTH - 1 downto 0) := "1011001100110011";
       constant m8: unsigned(BIT_WIDTH - 1 downto 0) := "1100110011001100";
       constant m9: unsigned(BIT_WIDTH - 1 downto 0) := "1110011001100110";

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
elsif Mantissa_Dividend < m6 then
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
elsif Mantissa_Dividend < m7 then
    if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(21),9);
    elsif Mantissa_Divisor < m2 then
        ROM_address:= to_unsigned(integer(22),9);
    elsif Mantissa_Divisor < m3 then
        ROM_address:= to_unsigned(integer(23),9);
    elsif Mantissa_Divisor < m4 then
        ROM_address:= to_unsigned(integer(24),9);
    elsif Mantissa_Divisor < m5 then
        ROM_address:= to_unsigned(integer(25),9);
    elsif Mantissa_Divisor < m6 then
        ROM_address:= to_unsigned(integer(26),9);
    else
        ROM_address:= to_unsigned(integer(27),9);
    end if;
elsif Mantissa_Dividend < m8 then
    if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(28),9);
    elsif Mantissa_Divisor < m2 then
        ROM_address:= to_unsigned(integer(29),9);
    elsif Mantissa_Divisor < m3 then
        ROM_address:= to_unsigned(integer(30),9);
    elsif Mantissa_Divisor < m4 then
        ROM_address:= to_unsigned(integer(31),9);
    elsif Mantissa_Divisor < m5 then
        ROM_address:= to_unsigned(integer(32),9);
    elsif Mantissa_Divisor < m6 then
        ROM_address:= to_unsigned(integer(33),9);
    elsif Mantissa_Divisor < m7 then
        ROM_address:= to_unsigned(integer(34),9);
    else
        ROM_address:= to_unsigned(integer(35),9);
    end if;
elsif Mantissa_Dividend < m9 then
    if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(36),9);
    elsif Mantissa_Divisor < m2 then
        ROM_address:= to_unsigned(integer(37),9);
    elsif Mantissa_Divisor < m3 then
        ROM_address:= to_unsigned(integer(38),9);
    elsif Mantissa_Divisor < m4 then
        ROM_address:= to_unsigned(integer(39),9);
    elsif Mantissa_Divisor < m5 then
        ROM_address:= to_unsigned(integer(40),9);
    elsif Mantissa_Divisor < m6 then
        ROM_address:= to_unsigned(integer(41),9);
    elsif Mantissa_Divisor < m7 then
        ROM_address:= to_unsigned(integer(42),9);
    elsif Mantissa_Divisor < m8 then
        ROM_address:= to_unsigned(integer(43),9);
    else
        ROM_address:= to_unsigned(integer(44),9);
    end if;
else
    if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(45),9);
    elsif Mantissa_Divisor < m2 then
        ROM_address:= to_unsigned(integer(46),9);
    elsif Mantissa_Divisor < m3 then
        ROM_address:= to_unsigned(integer(47),9);
    elsif Mantissa_Divisor < m4 then
        ROM_address:= to_unsigned(integer(48),9);
    elsif Mantissa_Divisor < m5 then
        ROM_address:= to_unsigned(integer(49),9);
    elsif Mantissa_Divisor < m6 then
        ROM_address:= to_unsigned(integer(50),9);
    elsif Mantissa_Divisor < m7 then
        ROM_address:= to_unsigned(integer(51),9);
    elsif Mantissa_Divisor < m8 then
        ROM_address:= to_unsigned(integer(52),9);
    elsif Mantissa_Divisor < m9 then
        ROM_address:= to_unsigned(integer(53),9);
    else
        ROM_address:= to_unsigned(integer(54),9);
    end if;
end if;



else
if Mantissa_Divisor < m1 then
        ROM_address:= to_unsigned(integer(55),9);
elsif Mantissa_Divisor < m2 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(56),9);
    else
        ROM_address:= to_unsigned(integer(57),9);
    end if;
elsif Mantissa_Divisor < m3 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(58),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(59),9);
    else
        ROM_address:= to_unsigned(integer(60),9);
    end if;
elsif Mantissa_Divisor < m4 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(61),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(62),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(63),9);
    else
        ROM_address:= to_unsigned(integer(64),9);
    end if;
elsif Mantissa_Divisor < m5 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(65),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(66),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(67),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(68),9);
    else
        ROM_address:= to_unsigned(integer(69),9);
    end if;
elsif Mantissa_Divisor < m6 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(70),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(71),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(72),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(73),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(74),9);
    else
        ROM_address:= to_unsigned(integer(75),9);
    end if;
elsif Mantissa_Divisor < m7 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(76),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(77),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(78),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(79),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(80),9);
    elsif Mantissa_Dividend < m6 then
        ROM_address:= to_unsigned(integer(81),9);
    else
        ROM_address:= to_unsigned(integer(82),9);
    end if;
elsif Mantissa_Divisor < m8 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(83),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(84),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(85),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(86),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(87),9);
    elsif Mantissa_Dividend < m6 then
        ROM_address:= to_unsigned(integer(88),9);
    elsif Mantissa_Dividend < m7 then
        ROM_address:= to_unsigned(integer(89),9);
    else
        ROM_address:= to_unsigned(integer(90),9);
    end if;
elsif Mantissa_Divisor < m9 then
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(91),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(92),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(93),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(94),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(95),9);
    elsif Mantissa_Dividend < m6 then
        ROM_address:= to_unsigned(integer(96),9);
    elsif Mantissa_Dividend < m7 then
        ROM_address:= to_unsigned(integer(97),9);
    elsif Mantissa_Dividend < m8 then
        ROM_address:= to_unsigned(integer(98),9);
    else
        ROM_address:= to_unsigned(integer(99),9);
    end if;
else
    if Mantissa_Dividend < m1 then
        ROM_address:= to_unsigned(integer(100),9);
    elsif Mantissa_Dividend < m2 then
        ROM_address:= to_unsigned(integer(101),9);
    elsif Mantissa_Dividend < m3 then
        ROM_address:= to_unsigned(integer(102),9);
    elsif Mantissa_Dividend < m4 then
        ROM_address:= to_unsigned(integer(103),9);
    elsif Mantissa_Dividend < m5 then
        ROM_address:= to_unsigned(integer(104),9);
    elsif Mantissa_Dividend < m6 then
        ROM_address:= to_unsigned(integer(105),9);
    elsif Mantissa_Dividend < m7 then
        ROM_address:= to_unsigned(integer(106),9);
    elsif Mantissa_Dividend < m8 then
        ROM_address:= to_unsigned(integer(107),9);
    elsif Mantissa_Dividend < m9 then
        ROM_address:= to_unsigned(integer(108),9);
    else
        ROM_address:= to_unsigned(integer(109),9);
    end if;
end if;


end if;


Addr <= std_logic_vector(ROM_address);
end process;
end Behavioral;
