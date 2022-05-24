%% generate test data for Vivado Reading
% Divisor, dividend assumed to have same format 
% has to be matched with VHDL source file.
% Quotient is 32bit wide
BIT_WIDTH = 16;
INTEGER_WIDTH = 12;
FRACTIONAL_WIDTH = BIT_WIDTH - INTEGER_WIDTH;

%% Generate if eles statement for Big_LUT.vhd (needs manual copy and paste.)
%Default is 10 by 10 Fitting Region
Generate_BigLUT


%% generate test data for Vivado Reading
% data stored in localDataIn.txt file
No_points = 300; %the higher the denser
Generate_stimulus_data(INTEGER_WIDTH,No_points)

%% Run Vivado Simulation, it would output data to DataOut.txt
% Reminder: Change the absolute addrees in simulation file of txt file.
% Both DataIn and DataOut



%% Analyse Simulation Output and generate error analysis
Analyse_Output(32,INTEGER_WIDTH)