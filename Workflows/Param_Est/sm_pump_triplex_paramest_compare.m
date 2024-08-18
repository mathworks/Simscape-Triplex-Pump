% Code to get simulation results with initial and tuned pressure settings
% for check valve in the triplex pump example.
%
% Copyright 2017-2024 The MathWorks, Inc.

sm_pump_triplex_config_model(bdroot,'Default');
sm_pump_triplex_paramest_values(bdroot,'initial');
sim(bdroot);
simlog_pO_init = simlog_sm_pump_triplex.Sensing_pq_Out.Pressure_Sensor.P;

sm_pump_triplex_paramest_values(bdroot,'final');
sim(bdroot);
simlog_pO_final = simlog_sm_pump_triplex.Sensing_pq_Out.Pressure_Sensor.P;

%% Plot Results
if ~exist('h10_sm_pump_triplex', 'var') || ...
        ~isgraphics(h10_sm_pump_triplex, 'figure')
    h10_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h10_sm_pump_triplex)
clf(h10_sm_pump_triplex)

stairs(pOutMeas_time,pOutMeas_data,'k','LineWidth', 1)
hold on
plot(simlog_pO_init.series.time,simlog_pO_init.series.values('bar'),'LineWidth', 2)
plot(simlog_pO_final.series.time,simlog_pO_final.series.values('bar'),'LineWidth', 2)
hold off
grid on
title('Pump Outlet Pressure')
legend({'Measured','Initial','Tuned'},'Location','Best');
ylabel('Pressure (bar)')
xlabel('Time (s)')


