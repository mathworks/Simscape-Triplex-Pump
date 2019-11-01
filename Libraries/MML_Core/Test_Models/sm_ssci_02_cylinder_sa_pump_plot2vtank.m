% Code to plot simulation results from sm_ssci_02_cylinder_sa_pump
%% Plot Description:
%
% The plot below shows the volume of the tank.  It decreases with each
% revolution of the pump shaft as fluid is drawn through the inlet check
% valve.
%
% Copyright 2017-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_ssci_02_cylinder_sa_pump', 'var')
    sim('sm_ssci_02_cylinder_sa_pump')
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_sm_ssci_02_cylinder_sa_pump', 'var') || ...
        ~isgraphics(h2_sm_ssci_02_cylinder_sa_pump, 'figure')
    h2_sm_ssci_02_cylinder_sa_pump = figure('Name', 'sm_ssci_02_cylinder_sa_pump');
end
figure(h2_sm_ssci_02_cylinder_sa_pump)
clf(h2_sm_ssci_02_cylinder_sa_pump)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_ssci_02_cylinder_sa_pump.Check_Valve_Input.flow_rate.series.time;
simlog_vTank  = simlog_sm_ssci_02_cylinder_sa_pump.Tank.V.series.values('l');

% Plot results
plot(simlog_t, simlog_vTank, 'LineWidth', 1)
grid on
title('Tank Volume')
ylabel('Volume (l)')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_vTank

