fid = fopen('Simulation_related_txt/DataOut.txt','r');
formatSpec = '%*d %*d %s';
B = textscan(fid,formatSpec); %B cell 
fclose(fid);