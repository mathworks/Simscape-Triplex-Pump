% Code to tune check valve pressure settings for the triplex pump
% example.  Sets up workspace and model, and opens parameter estimation
% tool.
%
% Copyright 2017-2022 The MathWorks, Inc.

mdlname = 'sm_pump_triplex';

%% Configure model to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference');

% Initial parameters
sm_pump_triplex_paramest_values(mdlname,'initial');


% Configure model
set_param([mdlname '/Driver'],'popup_driver_type','Dyno');
set_param([mdlname '/Pump'],'chkv_press_set_popup_P','Tune at Run Time');
open_system([mdlname '/Sensing pq Out/Compare/Output Pressure']);
set_param(mdlname,'StopTime','0.1');
set_param(mdlname,'FastRestart','on');


% Open parameter estimation tool with session data
load('sm_pump_triplex_spesession.mat')
sdotool(SDOSessionData);
