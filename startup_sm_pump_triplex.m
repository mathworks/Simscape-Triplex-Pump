% Startup file for triplex pump example
%
% Copyright 2017-2019 The MathWorks, Inc.

% Set up path
TRP_HomeDir = pwd;
dirlist = {...
    [TRP_HomeDir],...
    [TRP_HomeDir filesep 'Scripts_Data'],...
    [TRP_HomeDir filesep 'Libraries'],...
    [TRP_HomeDir filesep 'Libraries' filesep 'MPL_Libs'],...
    [TRP_HomeDir filesep 'Images'],...
    [TRP_HomeDir filesep 'CAD' filesep 'Import'],...
    [TRP_HomeDir filesep 'CAD' filesep 'SOLIDWORKS'],...
    [TRP_HomeDir filesep 'CAD' filesep 'STEP_Source'],...
    [TRP_HomeDir filesep 'Slides_Videos' filesep 'Loop_mp4'],...
    [TRP_HomeDir filesep 'Fault_Sweep'],...
    [TRP_HomeDir filesep 'Fault_Sweep' filesep 'Data'],...
    [TRP_HomeDir filesep 'ParamEst'],...
    [TRP_HomeDir filesep 'Fault_Detect'],...
    [TRP_HomeDir filesep 'html' filesep 'html'],...
    };

for dir_i = 1:length(dirlist)
    if(exist(dirlist{dir_i},'dir'))
        addpath(dirlist{dir_i});
    end
end

% Load Multiphysics Library
cd([TRP_HomeDir filesep 'Libraries' filesep 'MPL_Libs']);
startup_sm_ssci
cd(TRP_HomeDir)

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
cd([TRP_HomeDir filesep 'Fault_Sweep']);
sm_pump_triplex_DOEdata_tocsv(test_Results);
clear test_Results test_Nominal
cd(TRP_HomeDir);

web('sm_pump_triplex_Demo_Script.html');
%sm_pump_triplex
