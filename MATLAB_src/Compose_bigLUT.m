%Generate Big Lut VHD file directly.
No_fit_area = 10;
BIT_WIDTH = 16;

vhd = fopen('./MATLAB_vhd/big_LUT.vhd','wt');

%overhead
fprintf(vhd,'library IEEE;\n');
fprintf(vhd,'use IEEE.STD_LOGIC_1164.ALL;\n');
fprintf(vhd,'use IEEE.NUMERIC_STD.ALL;\n\n');

fprintf(vhd,'entity big_LUT is\n');
fprintf(vhd,'   generic(BIT_WIDTH : integer);\n');
fprintf(vhd,'   Port ( carry : in STD_LOGIC;\n');
fprintf(vhd,'       Mantissa_Dividend : in unsigned(BIT_WIDTH - 1 downto 0);\n');
fprintf(vhd,'       Mantissa_Divisor : in unsigned(BIT_WIDTH - 1 downto 0);\n');
fprintf(vhd,'       Addr : out std_logic_vector(8 downto 0)\n');
fprintf(vhd,'       );\n');
fprintf(vhd,'end big_LUT;\n\n');

%need rom configured as 1K *36bit, 12bit for each parameter

fprintf(vhd,'architecture Behavioral of big_LUT is\n');
fprintf(vhd,'begin\n');
fprintf(vhd,'   process(carry,Mantissa_Dividend,Mantissa_Divisor)\n');
fprintf(vhd,'       variable ROM_address:unsigned(8 downto 0):=(others => ''0\'');\n');

%Generate boundaries e.g   m1<0.2<m2
m_value = linspace(0,1,No_fit_area+1);
m_value = m_value(2:end-1);
for i = 1:length(m_value)
    fprintf(vhd,'       constant m%d: unsigned(BIT_WIDTH - 1 downto 0) := "',i);
    

    m_binary_matrix = convert2binary(m_value(i),0,BIT_WIDTH);
    for j = 1:length(m_binary_matrix)
        fprintf(vhd,'%d',m_binary_matrix(j));
    end 

    fprintf(vhd,'";\n');
end

fprintf(vhd,'\n');
fprintf(vhd,'       begin\n');
fprintf(vhd,'       if carry = ''0'' then\n\n\n\n');

%First Half Plane, no carry, mantissa_dividend > mantissa_divisor
No_element_array = -1;
for i = 1:No_fit_area
    if i == 1
        fprintf(vhd,'if Mantissa_Dividend < m%d then\n',i);
    elseif i == No_fit_area
        fprintf(vhd,'else\n');
    else
        fprintf(vhd,'elsif Mantissa_Dividend < m%d then\n',i);
    end 
    %fprintf(vhd,'elsif N_a_shifted > m%d\n',i);
    for j = 1:i
        if i == 1
            No_element_array = No_element_array + 1;
            fprintf(vhd,'        ROM_address:= to_unsigned(integer(%d),9);\n',No_element_array);
            break;
        end

        if j == 1
            fprintf(vhd,'    if Mantissa_Divisor < m%d then\n',j);
        elseif j == i
            fprintf(vhd,'    else\n');
        else
            fprintf(vhd,'    elsif Mantissa_Divisor < m%d then\n',j);

        end
        No_element_array = No_element_array + 1;
        fprintf(vhd,'        ROM_address:= to_unsigned(integer(%d),9);\n',No_element_array);
    end

    if i ~= 1 
        fprintf(vhd,'    end if;\n');
    end
    
end
fprintf(vhd,'end if;\n\n\n\n');

fprintf(vhd,'else\n');


for j = 1:No_fit_area
    if j == 1
        fprintf(vhd,'if Mantissa_Divisor < m%d then\n',j);
    elseif j == No_fit_area
        fprintf(vhd,'else\n');
    else
        fprintf(vhd,'elsif Mantissa_Divisor < m%d then\n',j);
    end 

    for i = 1:j
        if j == 1
            No_element_array = No_element_array + 1;
            fprintf(vhd,'        ROM_address:= to_unsigned(integer(%d),9);\n',No_element_array);
            break;
        end


        if i == 1
            fprintf(vhd,'    if Mantissa_Dividend < m%d then\n',i);
        elseif i == j
            fprintf(vhd,'    else\n');
        else
            fprintf(vhd,'    elsif Mantissa_Dividend < m%d then\n',i);

        end
   

        No_element_array = No_element_array + 1;
        fprintf(vhd,'        ROM_address:= to_unsigned(integer(%d),9);\n',No_element_array);

    end

    if i ~= 1
        fprintf(vhd,'    end if;\n');
    end




end 

fprintf(vhd,'end if;\n\n\n');
fprintf(vhd,'end if;\n\n\n');

fprintf(vhd,'Addr <= std_logic_vector(ROM_address);\n');
fprintf(vhd,'end process;\n');
fprintf(vhd,'end Behavioral;\n');
fclose(vhd);