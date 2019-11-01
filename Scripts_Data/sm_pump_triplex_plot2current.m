% Code to plot simulation results from sm_pump_triplex
%% Plot Description:
%
% The plot below shows the pressure at the output of the pump
% as well as the current draw of the motor driving the pump.
%
% Copyright 2017-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_pump_triplex', 'var')
    sim('sm_pump_triplex')
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_sm_pump_triplex', 'var') || ...
        ~isgraphics(h2_sm_pump_triplex, 'figure')
    h2_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h2_sm_pump_triplex)
clf(h2_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_pump_triplex.Pump.Plunger_1.Check_Valve_Outlet.flow_rate.series.time;
simlog_pO = simlog_sm_pump_triplex.Sensing_pq_Out.Pressure_Sensor.p.series.values('bar');
simlog_iM = simlog_sm_pump_triplex.Sensing_Current.Current_Sensor.I.series.values('A');

simlot_pOmeas = logsout_sm_pump_triplex.get('pOut_meas');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
%plot(simlog_t,simlog_pO,'LineWidth', 2,'Color',temp_colororder(5,:))
plot(simlot_pOmeas.Values.Time,simlot_pOmeas.Values.Data,'LineWidth', 2,'Color',temp_colororder(5,:))
hold off
grid on
title('Pump Outlet Pressure')
ylabel('Pressure (bar)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_iM, 'LineWidth', 1)
grid on
title('Motor Current')
ylabel('Current (A)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_pO simlog_iM 

