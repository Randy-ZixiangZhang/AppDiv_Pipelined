
%close all
%%
%half plane partition
%Manstissa _ Dividend > Divisor
% Output in Code1 txt


p = 10; %partition_region p*p
no_integer = 4;
no_fraction = 12;
no_total = no_integer + no_fraction;

para1 = cell(p,p);
GOOD = cell(p,p);


P00 = zeros(p,p);
P01 = zeros(p,p);
P10 = zeros(p,p);

fid = fopen('P2.txt','wt');


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

        p00 = convert2binary(c(1),no_integer,no_fraction);
        p01 = convert2binary(abs(c(2)),no_integer,no_fraction);
        p10 = convert2binary(c(3),no_integer,no_fraction);

        for l = 1:3
            for k = 1:no_total
                if l == 1 
                    fprintf(fid,'%d',p00(k));
                elseif l == 2
                    fprintf(fid,'%d',p01(k));
                else
                    fprintf(fid,'%d',p10(k));
                end 
            end
            fprintf(fid,'    ');
        end 
        fprintf(fid,'\n');
        
        %P00(i,j) = convert2binary(c(1),no_integer,no_fraction);
        %P01(i,j) = convert2binary(abs(c(2)),no_integer,no_fraction);
        %P10(i,j) = convert2binary(c(3),no_integer,no_fraction);
    end
end

fclose(fid);



fid2 = fopen('code.txt','wt');
for i = 1:p
    if i == 1
        fprintf(fid2,'if Mantissa_Dividend < m%d then\n',i);
    elseif i == p
        fprintf(fid2,'else\n');
    else
        fprintf(fid2,'elsif Mantissa_Dividend < m%d then\n',i);
    end 
    %fprintf(fid2,'elsif N_a_shifted > m%d\n',i);
    for j = 1:i
        if j == 1
            fprintf(fid2,'    if Mantissa_Divisor < m%d then\n',j);
        elseif j == i
            fprintf(fid2,'    else\n');
        else
            fprintf(fid2,'    elsif Mantissa_Divisor < m%d then\n',j);

        end
        
        c = para1{i,j};
        p00 = convert2binary(c(1),no_integer,no_fraction);
        p01 = convert2binary(abs(c(2)),no_integer,no_fraction);
        p10 = convert2binary(abs(c(3)),no_integer,no_fraction);

        for l = 1:3
            if l == 1
                fprintf(fid2,'        p00 := "');
            elseif l == 2
                fprintf(fid2,'        p10 := "');
            else
                fprintf(fid2,'        p01 := "');
            end

        


            for k = 1:no_total
                if l == 1 
                    fprintf(fid2,'%d',p00(k));
                elseif l == 2
                    fprintf(fid2,'%d',p01(k));
                else
                    fprintf(fid2,'%d',p10(k));
                end 
            end
            fprintf(fid,'";\n');
        end 
    end
    fprintf(fid2,'    end if;\n');
end
fprintf(fid2,'end if;\n');


fclose(fid2);







%%
%%
%half plane partition



p = 10; %partition_region p*p
no_integer = 4;
no_fraction = 12;
no_total = no_integer + no_fraction;

para2 = cell(p,p);

P00 = zeros(p,p);
P01 = zeros(p,p);
P10 = zeros(p,p);

fid = fopen('P3.txt','wt');


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

        p00 = convert2binary(c(1),no_integer,no_fraction);
        p01 = convert2binary(abs(c(2)),no_integer,no_fraction);
        p10 = convert2binary(abs(c(3)),no_integer,no_fraction);

        for l = 1:3
            for k = 1:no_total
                if l == 1 
                    fprintf(fid,'%d',p00(k));
                elseif l == 2
                    fprintf(fid,'%d',p01(k));
                else
                    fprintf(fid,'%d',p10(k));
                end 
            end
            fprintf(fid,'    ');
        end 
        fprintf(fid,'\n');
        
        %P00(i,j) = convert2binary(c(1),no_integer,no_fraction);
        %P01(i,j) = convert2binary(abs(c(2)),no_integer,no_fraction);
        %P10(i,j) = convert2binary(c(3),no_integer,no_fraction);
    end
end

fclose(fid);



fid2 = fopen('code2.txt','wt');
for j = 1:p
    if j == 1
        fprintf(fid2,'if Mantissa_Divisor < m%d then\n',j);
    elseif i == p
        fprintf(fid2,'else\n');
    else
        fprintf(fid2,'elsif Mantissa_Divisor < m%d then\n',j);
    end 

    for i = 1:j
        if i == 1
            fprintf(fid2,'    if Mantissa_Dividend < m%d then\n',i);
        elseif i == j
            fprintf(fid2,'    else\n');
        else
            fprintf(fid2,'    elsif Mantissa_Dividend < m%d then\n',i);

        end
        
        c = para2{i,j};
        p00 = convert2binary(c(1),no_integer,no_fraction);
        p01 = convert2binary(abs(c(2)),no_integer,no_fraction);
        p10 = convert2binary(abs(c(3)),no_integer,no_fraction);

        for l = 1:3
            if l == 1
                fprintf(fid2,'        p00 := "');
            elseif l == 2
                fprintf(fid2,'        p10 := "');
            else
                fprintf(fid2,'        p01 := "');
            end

        


            for k = 1:no_total
                if l == 1 
                    fprintf(fid2,'%d',p00(k));
                elseif l == 2
                    fprintf(fid2,'%d',p01(k));
                else
                    fprintf(fid2,'%d',p10(k));
                end 
            end
            fprintf(fid,'";\n');
        end 
    end
    fprintf(fid2,'    end if;\n');



end 


% fid2 = fopen('code2.txt','wt');
% for i = 1:p %p number of partition plane i = 10
%     if i == 1
%         fprintf(fid2,'if Mantissa_Dividend < m%d then\n',i);
%     elseif i == p
%         fprintf(fid2,'else\n');
%     else
%         fprintf(fid2,'elsif Mantissa_Dividend < m%d then\n',i);
%     end 
%     %fprintf(fid2,'elsif N_a_shifted > m%d\n',i);
%     for j = 1:p-i+1
%         if j == 1
%             fprintf(fid2,'    if Mantissa_Divisor < m%d then\n',j);
%         elseif j == p-i+1
%             fprintf(fid2,'    else\n');
%         else
%             fprintf(fid2,'    elsif Mantissa_Divisor < m%d then\n',j);
% 
%         end
%         
%         c = para2{i,p-j+1};
%         p00 = convert2binary(c(1),no_integer,no_fraction);
%         p01 = convert2binary(abs(c(2)),no_integer,no_fraction);
%         p10 = convert2binary(c(3),no_integer,no_fraction);
% 
%         for l = 1:3
%             if l == 1
%                 fprintf(fid2,'        p00 := "');
%             elseif l == 2
%                 fprintf(fid2,'        p10 := "');
%             else
%                 fprintf(fid2,'        p01 := "');
%             end
% 
%             for k = 1:no_total
%                 if l == 1 
%                     fprintf(fid2,'%d',p00(k));
%                 elseif l == 2
%                     fprintf(fid2,'%d',p01(k));
%                 else
%                     fprintf(fid2,'%d',p10(k));
%                 end 
%             end
%             fprintf(fid,'";\n');
%         end 
%     end
%     fprintf(fid2,'    end if;\n');
% end
% fprintf(fid2,'end if;\n');


fclose(fid2);





%%
function z = create_surface1(ma,mb)


        z = (1+ma)./(1+mb);%.*2;


end

function z = create_surface2(ma,mb)


        z = (1+ma)./(1+mb).*2;




end