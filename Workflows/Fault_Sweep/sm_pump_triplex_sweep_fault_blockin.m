% Code to sweep inlet port blockage for the triplex pump example and
% plot the results.
%
% Copyright 2017-2021 The MathWorks, Inc.

if (~exist('mdlname','var'))
    mdlname = 'sm_pump_triplex';
end
open_system(mdlname)

%% Define values for fault sweep
blockinfactor_set = linspace(0.8,0.53,10);

% Enable Fault as a run time parameter
sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On, Run Time',1);

%% Configure model to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Define tests by setting values for fault parameters
clear simInput
for temp_binfact_i = 1:length(blockinfactor_set)
    simInput(temp_binfact_i) = Simulink.SimulationInput(mdlname);
    simInput(temp_binfact_i) = ...
        simInput(temp_binfact_i).setVariable('block_in_factor_WKSP',...
        blockinfactor_set(temp_binfact_i));
end

%% Run tests using Fast Restart
simOut = [];
simOut = sim(simInput,'ShowProgress','off','UseFastRestart','on');

%% Disable fault and undo temporary settings
sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',1);
sm_pump_triplex_config_model(mdlname,'Vis','On');
warning('on','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Get simulation results
t_blkInRes = sm_pump_triplex_getMeas(simOut);

%% Plot results of sweep
% Reuse figure if it exists, else create new figure
if ~exist('h4_sm_pump_triplex', 'var') || ...
        ~isgraphics(h4_sm_pump_triplex, 'figure')
    h4_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h4_sm_pump_triplex)
clf(h4_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
hold on
for i=1:length(t_blkInRes)
    plot(t_blkInRes(i).sim.time, t_blkInRes(i).sim.qOut,'LineWidth',1);
end
hold off
title('Effect of Increasing Inlet Blockage (% of Max Valve Area)');
ylabel('Flow Rate (lpm)');
xlabel('Time (s)');
grid on
box on

legendstr = string([num2str([1-blockinfactor_set]'*100)])+'%';
legend(legendstr);

simlog_handles(2) = subplot(2, 1, 2);
hold on
for i=1:length(t_blkInRes)
    plot(t_blkInRes(i).sim.time, t_blkInRes(i).sim.iMotor,'LineWidth',1);
end
hold off
ylabel('Current (A)');
xlabel('Time (s)');
grid on
box on

linkaxes(simlog_handles, 'x');

clear simlog_handles temp_colororder 
clear simOut simInput
clear temp_vis_setting temp_mechexp_setting
