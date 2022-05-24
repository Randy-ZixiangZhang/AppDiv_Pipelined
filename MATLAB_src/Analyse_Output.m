function Analyse_Output(BIT_WIDTH,INTEGER_WIDTH)

fid = fopen('DataOut.txt','r');
formatSpec = '%d %d %*d';
sizeA = [2 inf]; 


A = fscanf(fid,formatSpec,sizeA);
fclose(fid);


fid = fopen('DataOut.txt','r');
formatSpec = '%*d %*d %s';

Data = zeros(size(A) + [1 0]);
Data(1:2,1:end) = A;
Data(4,:) = Data(1,:)./Data(2,:);

B = textscan(fid,formatSpec); %B cell 
fclose(fid);


total_bit_Q = BIT_WIDTH;
no_int = INTEGER_WIDTH;


no_quotient = size(A,2);

for i = 1 : no_quotient
    char_Q = B{1,1}{i,1};
    temp = 0;
    for j = 1:total_bit_Q
        single_bit = str2double(char_Q(j));
        temp = temp + single_bit * 2^(no_int - j);
    end
    Data(3,i) = temp;
end 



%how many bits supposed to take int representation


% temp = zeros(1,12);
% for i = 1:size(A,2)
%     temp = convert2binary(Data(3,i),no_int_simu,no_frac_simu);
%     t = 0;
%     for j = 1:(no_int_simu+no_frac_simu)
%         t = t + temp(j) * 2^(no_int-j);
%     end
%     Data(3,i) = t;
% end 

%first row dividend
%second row divisor
%third output collected from simulation







Error_Per = (Data(3,:) - Data(4,:))./Data(4,:) * 100;
%how many are over the error
disp('Percentage of points with error more than 1 %')
sum(abs(Error_Per) > 1)/size(Error_Per,2)*100
disp('Percentage of points with error more than 5 %')
sum(abs(Error_Per) > 5)/size(Error_Per,2)*100
disp('Percentage of points with error more than 10 %')
sum(abs(Error_Per) > 10)/size(Error_Per,2)*100
disp('Percentage of points with error more than 15 %')
sum(abs(Error_Per) > 15)/size(Error_Per,2)*100
disp('Percentage of points with error more than 20 %')
sum(abs(Error_Per) > 20)/size(Error_Per,2)*100
disp('Average Error in Percentage')
mean(abs(Error_Per))
disp('Maximum Error in Percentage')
max(abs(Error_Per))

% num_sampling = 1000;
% sampling_point = floor(linspace(1,size(Data,2),num_sampling));
% Data_sampled = Data(:,sampling_point);
% Error_Per_sampled = Error_Per(:,sampling_point);
% 
% [X,Y] = meshgrid(Data_sampled(1,:),Data_sampled(2,:));
% Error_Per_sampled = reshape(Error_Per_sampled,size(X));
% surf(X,Y,Error_Per_sampled);
plot3(Data(1,:),Data(2,:),Error_Per);


%% plot according to approximate regions
Data_Region = zeros(size(Data));
no_int = 12;no_frac = 4;
%convert Dividend to Dividend_Mantissa

for i = 1:size(A,2)
    temp = convert2binary(Data(1,i),no_int,no_frac);
    for  j = 1:(no_int+no_frac)
        if temp(j) == 1
            temp = circshift(temp,-j);
            temp(end - j + 1:end) = 0; %make sure the first 1 is replaced by 0
            break;
        end    
    end

    %get it back to decimal
    t = 0;
    for k = 1:(no_int+no_frac)
        t = t + temp(k)*2^(-k);
    end 
    Data_Region(1,i) = t;

end 

%convert Divisorto Dividend_Mantissa

for i = 1:size(A,2)
    temp = convert2binary(Data(2,i),no_int,no_frac);
    for  j = 1:(no_int+no_frac)
        if temp(j) == 1
            temp = circshift(temp,-j);
            temp(end - j + 1:end) = 0; %make sure the first 1 is replaced by 0
            break;
        end    
    end

    %get it back to decimal
    t = 0;
    for k = 1:(no_int+no_frac)
        t = t + temp(k)*2^(-k);
    end 
    Data_Region(2,i) = t;

end 

%Copy error data from Data
Data_Region(3:4,:) = Data(3:4,:);
%plot
plot3(Data_Region(1,:),Data_Region(2,:),Error_Per,'.','MarkerSize', 2);
xlabel('Dividend_mantissa');
ylabel('Divisor_mantissa');
zlabel('Error_100Percentage');

end