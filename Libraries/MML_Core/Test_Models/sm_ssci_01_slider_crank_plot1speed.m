% Code to plot simulation results from sm_ssci_01_slider_crank
%% Plot Description:
%
% The plot below shows the speed of the crank and slider as the crank
% is driven with a constant torque.
%
% Copyright 2017-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_ssci_01_slider_crank', 'var')
    sim('sm_ssci_01_slider_crank')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_ssci_01_slider_crank', 'var') || ...
        ~isgraphics(h1_sm_ssci_01_slider_crank, 'figure')
    h1_sm_ssci_01_slider_crank = figure('Name', 'sm_ssci_01_slider_crank');
end
figure(h1_sm_ssci_01_slider_crank)
clf(h1_sm_ssci_01_slider_crank)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_ssci_01_slider_crank.Revolute_Crank.Rz.w.series.time;
simlog_w1 = simlog_sm_ssci_01_slider_crank.Revolute_Crank.Rz.w.series.values('rev/s');
simlog_v1 = simlog_sm_ssci_01_slider_crank.Prismatic_Slider.Pz.v.series.values('m/s');

% Plot results
yyaxis left
plot(simlog_t, simlog_w1, 'LineWidth', 1)
ylabel('Crank Speed (rev/s)')
hold on

yyaxis right
plot(simlog_t, simlog_v1, 'LineWidth', 1)
ylabel('Slider Speed (m/s)')
hold off

grid on
title('Slider-Crank Speed')
xlabel('Time (s)')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_w1 simlog_v1 temp_colororder

