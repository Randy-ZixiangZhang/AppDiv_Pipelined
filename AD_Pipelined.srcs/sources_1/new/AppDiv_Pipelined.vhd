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
        Clk: in std_logic;
        Reset:in std_logic;
        Quotient:out unsigned (27 downto 0)
    );
end AppDiv_Pipelined;

architecture Structural of AppDiv_Pipelined is
    
    constant BIT_WIDTH:integer := 16;


    -- first stage of pipeline
    component shift_unit
        generic(BIT_WIDTH: integer:= BIT_WIDTH);
        Port ( N : in unsigned(BIT_WIDTH - 1 downto 0);
           Exp : out integer range 0 to BIT_WIDTH - 1;
           N_s : out unsigned(BIT_WIDTH - 1 downto 0));
    end component;
    
    component mantissa_register
        generic(BIT_WIDTH: integer:= BIT_WIDTH);
        port(CLK,RESET: in std_logic;
            D: in unsigned (BIT_WIDTH - 1 downto 0);
            Q: out unsigned (BIT_WIDTH - 1 downto 0));
    end component;
    
    component expo_reg
        generic( BIT_WIDTH: integer:= BIT_WIDTH);
        port(CLK,RESET: in std_logic;
            D: in integer range 0 to BIT_WIDTH - 1;
            Q: out integer range 0 to BIT_WIDTH - 1);
    end component;

    -- end of first stage pipeline

    
    -- START Second Pipeline Stage
    component comp_unit
        generic(BIT_WIDTH: integer:= BIT_WIDTH);
        Port ( Mantissa_Dividend : in unsigned (BIT_WIDTH-1 downto 0);
           Mantissa_Divisor : in unsigned (BIT_WIDTH-1 downto 0);
           Carry : out STD_LOGIC);
    end component;    
    
    component expo_unit
        generic(BIT_WIDTH: integer:=BIT_WIDTH);
        Port ( Expo_A : in integer range 0 to BIT_WIDTH-1;
               Expo_B : in integer range 0 to BIT_WIDTH-1;
               Carry : in STD_LOGIC;
               Num_shift : out integer range 0 to BIT_WIDTH-1);
    end component;
    
    component num_shift_reg
        generic(BIT_WIDTH: integer:=BIT_WIDTH);
        port(CLK,RESET: in std_logic;
            D: in integer range 0 to BIT_WIDTH-1;
            Q: out integer range 0 to BIT_WIDTH-1);
    end component;
    
    component carry_reg
        port(CLK,RESET: in std_logic;
            D: in std_logic;
            Q: out std_logic);
    end component; 
 
    -- END Second Pipeline Stage   
    

    -- START PIPELINE STAGE3 BIGLUT
    component big_LUT
        generic(BIT_WIDTH: integer:=BIT_WIDTH);
        Port ( carry : in STD_LOGIC;
               Mantissa_Dividend : in unsigned(BIT_WIDTH - 1 downto 0);
               Mantissa_Divisor : in unsigned(BIT_WIDTH - 1 downto 0);
               Addr : out std_logic_vector(8 downto 0)
           );   
    end component;
    
    component address_reg
        port(CLK,RESET: in std_logic;
            D: in std_logic_vector(8 downto 0);
            Q: out std_logic_vector(8 downto 0));
    end component;
    -- END PIPELINE STAGE3 BIGLUT


    -- 4 
    component AppDiv_ROM
       Port ( clk : in std_logic;
           addr : in std_logic_vector(8 downto 0);
           data : out unsigned(35 downto 0)
           );
    end component;
    
    component data_reg
        port(CLK,RESET: in std_logic;
            D: in unsigned(35 downto 0);
            Q: out unsigned(35 downto 0));
    end component;
    -- end 4

    
    component arithmetic_unit
           generic(BIT_WIDTH: integer:=BIT_WIDTH);
           Port ( 
               Mantissa_Dividend: in unsigned (BIT_WIDTH-1 downto 0);
               Mantissa_Divisor: in unsigned (BIT_WIDTH-1 downto 0);
               data : in  unsigned (35 downto 0);
               Num_shift : in integer range 0 to BIT_WIDTH-1;
               Quotient : out unsigned (BIT_WIDTH-1 + 12 downto 0));
    end component;


    -- ------------------------INTERMEDIATE SIGNAL DECLARATION----------------------------------------
    
    -- first stage
    signal ExpA: integer range 0 to BIT_WIDTH - 1;
    signal ExpB: integer range 0 to BIT_WIDTH - 1;

    signal mantissa_dividend: unsigned (BIT_WIDTH - 1 downto 0);
    signal mantissa_divisor: unsigned (BIT_WIDTH - 1 downto 0);
    
    signal matisa_A_reg_out1:unsigned (BIT_WIDTH - 1 downto 0);
    signal matisa_B_reg_out1:unsigned (BIT_WIDTH - 1 downto 0);
    signal expo_A_out1:integer range 0 to BIT_WIDTH - 1;
    signal expo_B_out1:integer range 0 to BIT_WIDTH - 1;
    -- end of first stage
    
    -- START Second Pipeline Stage
    signal carry:std_logic;
    signal carry_reg_out:std_logic;
    signal num_shift: integer range 0 to BIT_WIDTH - 1;
    signal num_shift_reg_out: integer range 0 to BIT_WIDTH - 1;
    signal matisa_A_reg_out2:unsigned (BIT_WIDTH - 1 downto 0);
    signal matisa_B_reg_out2:unsigned (BIT_WIDTH - 1 downto 0);
    
    
    -- END Second Pipeline Stage
    
    
    signal addr_sig:std_logic_vector(8 downto 0);
    signal matisa_A_reg_out3:unsigned (BIT_WIDTH - 1 downto 0);
    signal matisa_B_reg_out3:unsigned (BIT_WIDTH - 1 downto 0);
    signal num_shift_reg_out2: integer range 0 to BIT_WIDTH - 1;
    signal addr_reg_out:std_logic_vector(8 downto 0);
    
 
 
    signal data_sig:unsigned(35 downto 0);
    signal data_reg_out:unsigned(35 downto 0);
    signal matisa_A_reg_out4:unsigned (BIT_WIDTH - 1 downto 0);
    signal matisa_B_reg_out4:unsigned (BIT_WIDTH - 1 downto 0);
    signal num_shift_reg_out3: integer range 0 to BIT_WIDTH - 1;    
    
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

    expo_A_reg:expo_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => ExpA,
                Q => expo_A_out1              
                );
                
    expo_B_reg:expo_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => ExpB,
                Q => expo_B_out1              
                );                        
            
    -- end of first stage AppDiv_Pipelined
    
    
    
    -- START Second Pipeline Stage
    comp:comp_unit port map(
                Mantissa_Dividend => matisa_A_reg_out1,
                Mantissa_Divisor => matisa_B_reg_out1,
                Carry => carry
    );
    
    exp: expo_unit port map(
                Expo_A => expo_A_out1,
                Expo_B => expo_B_out1,
                Carry => carry,
                Num_shift => num_shift
    );
    
    mtisa_A_reg_stage2:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_A_reg_out1,
                Q => matisa_A_reg_out2
                );

    mtisa_B_reg_stage2:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_B_reg_out1,
                Q => matisa_B_reg_out2           
                );
    
    num_reg:num_shift_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => num_shift,
                Q => num_shift_reg_out
    );
    
    car_reg:carry_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => carry,
                Q => carry_reg_out
    );
    -- END Second Pipeline Stage
    
    
    -- START PIPELINE STAGE3 BIGLUT
    
    big:big_LUT port map(
               carry => carry_reg_out,
               Mantissa_Dividend => matisa_A_reg_out2,
               Mantissa_Divisor => matisa_B_reg_out2,
               Addr => addr_sig
        
    );
    
    mtisa_A_reg_stage3:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_A_reg_out2,
                Q => matisa_A_reg_out3
                );

    mtisa_B_reg_stage3:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_B_reg_out2,
                Q => matisa_B_reg_out3           
                );
                
    num_reg2:num_shift_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => num_shift_reg_out,
                Q => num_shift_reg_out2
    );
    
    addr_reg:address_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => addr_sig,
                Q => addr_reg_out
    );
    
    -- END PIPELINE STAGE3 BIGLUT
    
    
    
    -- four
    rom:AppDiv_ROM port map(
        CLK => Clk,
       addr => addr_reg_out,
       data => data_sig
    );
    
    d_reg:data_reg port map(
        CLK => Clk,
        RESET => Reset,
        D => data_sig,
        Q => data_reg_out
    );
    
    mtisa_A_reg_stage4:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_A_reg_out3,
                Q => matisa_A_reg_out4
                );

    mtisa_B_reg_stage4:mantissa_register port map(
                CLK => Clk,
                RESET => Reset,
                D => matisa_B_reg_out3,
                Q => matisa_B_reg_out4           
                );
                
    num_reg3:num_shift_reg port map(
                CLK => Clk,
                RESET => Reset,
                D => num_shift_reg_out2,
                Q => num_shift_reg_out3
    );
    
    
    arith: arithmetic_unit port map(
                Mantissa_Dividend =>matisa_A_reg_out4,
                Mantissa_Divisor =>matisa_B_reg_out4,
                data => data_reg_out,
                Num_shift => num_shift_reg_out3,
                Quotient => Quotient
    );
    
    -- end memory read
    end Structural;
