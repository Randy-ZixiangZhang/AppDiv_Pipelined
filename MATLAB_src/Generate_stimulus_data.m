function Generate_stimulus_data(INTEGER_WIDTH,POINT)
max = 2^INTEGER_WIDTH-1;

point = POINT;

fid = fopen('DataIn.txt','wt');

m_i = floor(linspace(max,1,point));
for i = m_i(1:end-1)
    for j = floor(linspace(i,1,floor(point*i/max))) %lower the amount of points generated in when dividend smaller
         fprintf(fid,'%d %d\n',i,j);
    end
end


fclose(fid);
end 
