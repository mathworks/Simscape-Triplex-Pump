function sm_pump_triplex_paramest_values(mdlname, value_set)
% Code to load check valve pressure settings into MATLAB workspace.
%
% Copyright 2017-2024 The MathWorks, Inc.

switch lower(value_set)
    case 'initial'
        % Values before tuning
        chkv_all_crkP_WKSP     = 50000;  % Pa
        chkv_all_maxOpenP_WKSP = 140000; % Pa
    case 'final'
        % Values after tuning to measured data
        chkv_all_crkP_WKSP     = 30000;  % Pa
        chkv_all_maxOpenP_WKSP = 120000; % Pa
end

assignin('base','chkv_all_crkP_WKSP',chkv_all_crkP_WKSP);
assignin('base','chkv_all_maxOpenP_WKSP',chkv_all_maxOpenP_WKSP);

set_param([mdlname '/Driver'],'popup_driver_type','Dyno');
set_param([mdlname '/Pump'],'chkv_press_set_popup_P','Tune at Run Time');
open_system([mdlname '/Sensing pq Out/Compare/Output Pressure']);
set_param(mdlname,'StopTime','0.1');
sm_pump_triplex_config_model(mdlname,'Diagnostics','Off');

end
