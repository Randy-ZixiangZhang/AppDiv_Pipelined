No_fit_area = 10;

%one location, bit budget 36bits
UNIT_WIDTH = 12;
%three parameters stacked into one p00 p01 p10


%half plane partition
%Manstissa _ Dividend > Divisor
p = No_fit_area; %partition_region p*p

para1 = cell(p,p);
GOOD = cell(p,p);
fid = fopen('./MATLAB_vhd/P2.txt','wt');

record_max = 0;
for i = 1:p
    for j = 1:p
        x = ((1/p)*(i-1)):0.01:((1/p)*i);
        y = ((1/p)*(j-1)):0.01:((1/p)*j);

        [X,Y] = meshgrid(x,y);
        Z = create_surface1(X,Y);

        %[za,goodness] = fit([X(:),Y(:)],Z(:),'poly11');
        [za, goodness] = fit([X(:),Y(:)],Z(:),'poly11');
        c = coeffvalues(za);
        GOOD{i,j} = goodness;
        para1{i,j} = c;
        %M_a along column, M_b along row
        fprintf(fid,'M_a = %d, M_b = %d\n',i,j);
        fprintf(fid,'%.5f,%.5f,%.5f\n',c(1),c(2),c(3));
        
        %help decide how many bit should be assigned to integer part
        this_max = max(abs(c));
        if this_max > record_max
            record_max = this_max;
        end
        
    end
end

fclose(fid);

%second half plane partition

p = 10; %partition_region p*p
no_integer = 4;
no_fraction = 12;
no_total = no_integer + no_fraction;

para2 = cell(p,p);

P00 = zeros(p,p);
P01 = zeros(p,p);
P10 = zeros(p,p);

fid = fopen('./MATLAB_vhd/P3.txt','wt');


for i = 1:p
    for j = 1:p
        x = ((1/p)*(i-1)):0.01:((1/p)*i);
        y = ((1/p)*(j-1)):0.01:((1/p)*j);
        
        [X,Y] = meshgrid(x,y);
        Z = create_surface2(X,Y);

        %[za,goodness] = fit([X(:),Y(:)],Z(:),'poly11');
        za = fit([X(:),Y(:)],Z(:),'poly11');
        c = coeffvalues(za);
        para2{i,j} = c;
        %M_a along column, M_b along row
        fprintf(fid,'M_a = %d, M_b = %d\n',i,j);
        fprintf(fid,'%.5f,%.5f,%.5f\n',c(1),c(2),c(3));

        this_max = max(abs(c));
        if this_max > record_max
            record_max = this_max;
        end       

    end
end

fclose(fid);


no_int = floor((log2((record_max))+1));

fprintf('bits for integer representation %d\n',no_int);



%start writing ROM


vhd = fopen('./MATLAB_vhd/AppDiv_ROM.vhd','wt');
fprintf(vhd,'library IEEE;\n');
fprintf(vhd,'use IEEE.STD_LOGIC_1164.ALL;\n');
fprintf(vhd,'use ieee.std_logic_unsigned.all;\n');
fprintf(vhd,'use IEEE.NUMERIC_STD.ALL;\n\n');

fprintf(vhd,'entity AppDiv_ROM is\n');
fprintf(vhd,'   Port ( clk : in bit;\n');
fprintf(vhd,'       addr : in std_logic_vector(8 downto 0);\n');
fprintf(vhd,'       data : out unsigned(35 downto 0)\n');
fprintf(vhd,'       );\n');
fprintf(vhd,'end AppDiv_ROM;\n\n');
fprintf(vhd,'architecture behavioral of AppDiv_ROM is\n');
fprintf(vhd,'type rom_type is array (0 to %d) of unsigned(35 downto 0);\n',No_element_array);
fprintf(vhd,'signal ROM : rom_type := (\n');



No_element_array = -1;

for i = 1:p
    for j = 1:i
        
        c = para1{i,j};
        p00 = convert2binary(c(1),no_int,UNIT_WIDTH-no_int);
        p01 = convert2binary(abs(c(2)),no_int,UNIT_WIDTH-no_int);
        p10 = convert2binary(abs(c(3)),no_int,UNIT_WIDTH-no_int);

        No_element_array = No_element_array + 1;
        fprintf(vhd,'"');
        for l = 1:3
            for k = 1:UNIT_WIDTH
                if l == 1 
                    fprintf(vhd,'%d',p00(k));
                elseif l == 2
                    fprintf(vhd,'%d',p01(k));
                else
                    fprintf(vhd,'%d',p10(k));
                end 
            end
        end 
        fprintf(vhd,'",\n');
    end
end

for j = 1:p
    for i = 1:j
        c = para2{i,j};
        p00 = convert2binary(c(1),no_int,UNIT_WIDTH-no_int);
        p01 = convert2binary(abs(c(2)),no_int,UNIT_WIDTH-no_int);
        p10 = convert2binary(abs(c(3)),no_int,UNIT_WIDTH-no_int);

        No_element_array = No_element_array + 1;

        fprintf(vhd,'"');
        for l = 1:3
            for k = 1:UNIT_WIDTH
                if l == 1 
                    fprintf(vhd,'%d',p00(k));
                elseif l == 2
                    fprintf(vhd,'%d',p01(k));
                else
                    fprintf(vhd,'%d',p10(k));
                end 
            end
        end 

        if j == p && i == j
            fprintf(vhd,'"');
            break;
        end
        fprintf(vhd,'",\n');
        
    end
end 

fprintf(vhd,');\n');
fprintf(vhd,'    attribute rom_style : string;\n');
fprintf(vhd,'    attribute rom_style of ROM : signal is "block";\n');
fprintf(vhd,'begin\n');
fprintf(vhd,'   process(clk)\n');
fprintf(vhd,'   begin\n');
fprintf(vhd,'       if rising_edge(clk) then\n');
fprintf(vhd,'           data <= ROM(conv_integer(std_logic_vector(addr)));\n');
fprintf(vhd,'       end if;\n');
fprintf(vhd,'   end process;\n');
fprintf(vhd,'end behavioral;\n');


%%
function z = create_surface1(ma,mb)
        z = (1+ma)./(1+mb);

end

function z = create_surface2(ma,mb)
        z = (1+ma)./(1+mb).*2 ;
end