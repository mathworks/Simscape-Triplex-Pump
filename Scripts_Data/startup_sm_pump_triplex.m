% Startup file for triplex pump example
%
% Copyright 2017-2021 The MathWorks, Inc.

% Set up path
TRP_HomeDir = pwd;

% Load Parameters
sm_pump_triplex_param
CAT_Pump_1051_DataFile_imported

% Load Measured Data
load pOutMeas
end_index = find(pOutMeas_time==0.1);
pOutMeas_time = pOutMeas_time(1:end_index);
pOutMeas_data = pOutMeas_data(1:end_index);

% Create Measurement CSV Files
load('sm_pump_triplex_DOEdata.mat')
cd(fileparts(which('sm_pump_triplex_DOEdata_tocsv.m')));
sm_pump_triplex_DOEdata_tocsv(test_Results);
clear test_Results test_Nominal
cd(fileparts(which('sm_pump_triplex.slx')));

web('sm_pump_triplex_Demo_Script.html');
%sm_pump_triplex
