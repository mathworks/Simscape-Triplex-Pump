% Code to sweep inlet port blockage for the triplex pump example and
% plot the results.
%
% Copyright 2017-2019 The MathWorks, Inc.

if (~exist('mdlname','var'))
    mdlname = 'sm_pump_triplex';
end
open_system(mdlname)

%% Define values for fault sweep
bearingfactor_set = linspace(0,9e-4,10);

% Enable Fault as a run time parameter
sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On, Run Time');

%% Configure model to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Store simulation inputs
clear simInput
for temp_binfact_i = 1:length(bearingfactor_set)
    simInput(temp_binfact_i) = Simulink.SimulationInput(mdlname);
    simInput(temp_binfact_i) = ...
        simInput(temp_binfact_i).setVariable('bearing_fault_frict_WKSP',...
        bearingfactor_set(temp_binfact_i));
end

%% Run simulation using Fast Restart
simOut = [];
simOut = sim(simInput,'ShowProgress','off','UseFastRestart','on');

%% Disable fault; Undo temporary settings
sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','Off');
sm_pump_triplex_config_model(mdlname,'Vis','On');
warning('on','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Get simulation results
t_bearWRes = sm_pump_triplex_getMeas(simOut);

%% Reuse figure if it exists, else create new figure
if ~exist('h5_sm_pump_triplex', 'var') || ...
        ~isgraphics(h5_sm_pump_triplex, 'figure')
    h5_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h5_sm_pump_triplex)
clf(h5_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
hold on
for i=1:length(t_bearWRes)
    plot(t_bearWRes(i).sim.time,t_bearWRes(i).sim.qOut,'LineWidth',1);
end
hold off
title('Effect of Increasing Bearing Wear (Added Friction, N*mm/(deg/s))');
ylabel('Flow Rate (lpm)');
grid on
box on

legendstr = string([num2str([bearingfactor_set]'*1000)]);
legend(legendstr);

simlog_handles(2) = subplot(2, 1, 2);
hold on
for i=1:length(simOut)
    plot(t_bearWRes(i).sim.time,t_bearWRes(i).sim.iMotor,'LineWidth',1);
end
hold off
ylabel('Current (A)');
xlabel('Time (s)');
grid on
box on

linkaxes(simlog_handles, 'x');

clear simlog_handles temp_colororder 
clear simInput simOut
clear temp_vis_setting temp_mechexp_setting
