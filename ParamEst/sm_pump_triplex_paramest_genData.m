% Code to generate example measured data for parameter tuning.
%
% Copyright 2017-2018 The MathWorks, Inc.

%% Configure model for dyno test
set_param([mdlname '/Driver'],'popup_driver_type','Dyno');
set_param(mdlname,'StopTime','0.5');

TRP_Par.Check_Valve.In.Max_Area     = 1e-4;  % m^2
TRP_Par.Check_Valve.In.Crack_Pr     = 0.3e5; % Pa
TRP_Par.Check_Valve.In.Max_Open_Pr  = 1.2e5;  % Pa

TRP_Par.Check_Valve.Out.Max_Area    = 1e-4;  % m^2
TRP_Par.Check_Valve.Out.Crack_Pr    = 0.3e5; % Pa
TRP_Par.Check_Valve.Out.Max_Open_Pr = 1.2e5;  % Pa


TRP_Par.Sensors.p.Ts = 5e-4; % Different sample time for measure data
sim(bdroot);
TRP_Par.Sensors.p.Ts = 1e-3; % Reset

temp_pOutMeas = logsout_sm_pump_triplex.get('pOut_meas');

pOutMeas_time = temp_pOutMeas.Values.Time;
pOutMeas_data = temp_pOutMeas.Values.Data;

set_param([mdlname '/Driver'],'popup_driver_type','Motor');

set_param(mdlname,'StopTime','1.5');

save pOutMeas pOutMeas_time pOutMeas_data

