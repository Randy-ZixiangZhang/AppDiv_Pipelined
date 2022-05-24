----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2022 10:11:23 AM
-- Design Name: 
-- Module Name: AppDiv_Pipelined - Behavioral
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

entity AppDiv_Pipelined is
    Port(Dividend:in unsigned (15 downto 0);
        Divisor:in unsigned (15 downto 0);
        Clk: in bit;
        Reset:in bit;
        Quotient:out unsigned (31 downto 0)
    );
end AppDiv_Pipelined;

architecture Structural of AppDiv_Pipelined is
    
    constant BIT_WIDTH:integer := 15;


    -- first stage of pipeline
    component shift_unit
        generic(BIT_WIDTH: integer:= BIT_WIDTH);
        Port ( N : in unsigned;
           Exp : out integer;
           N_s : out unsigned);
    end component;
    
    component mantissa_register
        generic(BIT_WIDTH: integer:= BIT_WIDTH);
        port(CLK,RESET: in bit;
            D: in unsigned (BIT_WIDTH - 1 downto 0);
            Q: out unsigned (BIT_WIDTH - 1 downto 0));
    end component;
    
    component expo_regsiter
        generic( BIT_WIDTH: integer:= BIT_WIDTH);
        port(CLK,RESET: in bit;
            D: in integer range 0 to BIT_WIDTH - 1;
            Q: out integer range 0 to BIT_WIDTH - 1);
    end component;

    -- end of first stage pipeline


    -- intermediate signal declaration
    
    -- first stage
    signal ExpA: integer range 0 to BIT_WIDTH;
    signal ExpB: integer range 0 to BIT_WIDTH;

    signal mantissa_dividend: unsigned (BIT_WIDTH - 1 downto 0);
    signal mantissa_divisor: unsigned (BIT_WIDTH - 1 downto 0);
    
    signal matisa_A_reg_out1:unsigned (BIT_WIDTH - 1 downto 0);
    signal matisa_B_reg_out1:unsigned (BIT_WIDTH - 1 downto 0);
    signal expo_A_out1:integer range 0 to BIT_WIDTH - 1;
    signal expo_B_out1:integer range 0 to BIT_WIDTH - 1;
    -- end of first stage
    
begin

    -- first stage of pipeline
    shift_dividend:shift_unit port map(
                N => Dividend,
                Exp =>  ExpA,
                N_s => mantissa_dividend
                );
    shift_divisor:shift_unit port map(
                N => Divisor,
                Exp =>  ExpB,
                N_s => mantissa_divisor
                );

    mtisa_divd_reg:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => mantissa_dividend,
                Q => matisa_A_reg_out1
                );

    mtisa_divisor_reg:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => mantissa_divisor,
                Q => matisa_B_reg_out1           
                );

    expoA_reg:expo_regsiter port map(
                CLK => Clk,
                RESET => Reset,
                D => ExpA,
                Q => expo_A_out1              
                );
                
   expoB_reg:expo_regsiter port map(
                CLK => Clk,
                RESET => Reset,
                D => ExpB,
                Q => expo_B_out1              
                );                        
            
    -- end of first stage AppDiv_Pipelined
    
    
    
    end Structural;
