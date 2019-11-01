% Code to plot simulation results from sm_ssci_02_cylinder_sa_pump
%% Plot Description:
%
% The plot below shows the flow rate into and out of the pump.
%
% Copyright 2017-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_ssci_02_cylinder_sa_pump', 'var')
    sim('sm_ssci_02_cylinder_sa_pump')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_ssci_02_cylinder_sa_pump', 'var') || ...
        ~isgraphics(h1_sm_ssci_02_cylinder_sa_pump, 'figure')
    h1_sm_ssci_02_cylinder_sa_pump = figure('Name', 'sm_ssci_02_cylinder_sa_pump');
end
figure(h1_sm_ssci_02_cylinder_sa_pump)
clf(h1_sm_ssci_02_cylinder_sa_pump)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_ssci_02_cylinder_sa_pump.Check_Valve_Input.flow_rate.series.time;
simlog_qChkvI  = simlog_sm_ssci_02_cylinder_sa_pump.Check_Valve_Input.flow_rate.series.values('lpm');
simlog_qChkvO  = simlog_sm_ssci_02_cylinder_sa_pump.Check_Valve_Output.flow_rate.series.values('lpm');
simlog_pPiston = simlog_sm_ssci_02_cylinder_sa_pump.Prismatic_Piston.Pz.v.series.values('m/s');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_qChkvI, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_qChkvO, 'LineWidth', 1)
hold off
grid on
title('Pump Flow Rates')
ylabel('Flow Rate (lpm)')
legend({'Inlet','Outlet'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_pPiston, 'LineWidth', 1)
grid on
title('Piston Velocity')
ylabel('Velocity (m/s)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_qChkvI simlog_qChkvO simlog_pPiston

