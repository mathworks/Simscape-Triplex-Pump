function results = sm_pump_triplex_getMeas(simOut_var)
% Code to extract signals representing measurements
% from the single simulation output of sm_pump_triplex
%
% Copyright 2017-2023 The MathWorks, Inc.

for i=1:length(simOut_var)
    results(i).sim.time   = simOut_var(i).simlog_sm_pump_triplex.Sensing_pq_Out.Flow_Rate_Sensor.V.series.time;
    results(i).sim.qOut   = simOut_var(i).simlog_sm_pump_triplex.Sensing_pq_Out.Flow_Rate_Sensor.V.series.values('lpm');
    results(i).sim.iMotor = simOut_var(i).simlog_sm_pump_triplex.Sensing_Current.Current_Sensor.I.series.values('A');
    results(i).sim.pIn    = simOut_var(i).simlog_sm_pump_triplex.Sensing_pq_In.Pressure_Sensor.P.series.values('bar');
    results(i).sim.pOut   = simOut_var(i).simlog_sm_pump_triplex.Sensing_pq_Out.Pressure_Sensor.P.series.values('bar');
    
    temp_iqOutMeas = simOut_var(i).logsout_sm_pump_triplex.get('qOut_meas');
    temp_iMotMeas = simOut_var(i).logsout_sm_pump_triplex.get('iMotor_meas');
    temp_wMotMeas = simOut_var(i).logsout_sm_pump_triplex.get('wMotor_meas');
    temp_pInMeas = simOut_var(i).logsout_sm_pump_triplex.get('pIn_meas');
    temp_pOutMeas = simOut_var(i).logsout_sm_pump_triplex.get('pOut_meas');

    % Simulated speed taken from logsout because in Dyno variant there is
    % no motor block.
    %temp_wMotSim = simOut_var(i).logsout_sm_pump_triplex.get('wMotor_sim');
    
    results(i).meas.time   = temp_iqOutMeas.Values.Time;
    results(i).meas.qOut   = temp_iqOutMeas.Values.Data;
    results(i).meas.iMotor = temp_iMotMeas.Values.Data;
    results(i).meas.wMotor = temp_wMotMeas.Values.Data;
    %results(i).sim.wMotor  = temp_wMotSim.Values.Data;
    results(i).meas.pIn    = temp_pInMeas.Values.Data;
    results(i).meas.pOut   = temp_pOutMeas.Values.Data;

end