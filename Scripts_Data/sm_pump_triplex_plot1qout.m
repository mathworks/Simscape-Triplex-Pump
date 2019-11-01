% Code to plot simulation results from sm_pump_triplex
%% Plot Description:
%
% The plot below shows the volumetric flow rate at the output of each
% plunger as well as the overall output of the pump.
%
% Copyright 2017-2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_pump_triplex', 'var')
    sim('sm_pump_triplex')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_pump_triplex', 'var') || ...
        ~isgraphics(h1_sm_pump_triplex, 'figure')
    h1_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h1_sm_pump_triplex)
clf(h1_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_pump_triplex.Pump.Plunger_1.Check_Valve_Outlet.flow_rate.series.time;
simlog_q1 = simlog_sm_pump_triplex.Pump.Plunger_1.Check_Valve_Outlet.flow_rate.series.values('lpm');
simlog_q2 = simlog_sm_pump_triplex.Pump.Plunger_2.Check_Valve_Outlet.flow_rate.series.values('lpm');
simlog_q3 = simlog_sm_pump_triplex.Pump.Plunger_3.Check_Valve_Outlet.flow_rate.series.values('lpm');
simlog_qA = simlog_sm_pump_triplex.Sensing_pq_Out.Flow_Rate_Sensor.q.series.values('lpm');

simlog_wP = simlog_sm_pump_triplex.Pump.Crank_Bearing.Rz.w.series.values('rpm');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_q1,...
    simlog_t, simlog_q2,...
    simlog_t, simlog_q3,'LineWidth', 1)
hold on
plot(simlog_t,simlog_qA,'LineWidth', 2)
hold off
grid on
title('Volumetric Flow Rate at Output')
ylabel('Flow Rate (lpm)')
legend({'Plunger 1','Plunger 2','Plunger 3','Pump'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_wP, 'LineWidth', 1)
grid on
title('Pump Speed')
ylabel('Speed (rpm)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_R1i simlog_C1v temp_colororder

