% Code to sweep leakage area for the triplex pump example and
% plot the results.
%
% Copyright 2017-2024 The MathWorks, Inc.

if (~exist('mdlname','var'))
    mdlname = 'sm_pump_triplex';
end
open_system(mdlname)

%% Define values for fault sweep
leak_area_set_factor = linspace(0.00,0.036,10);
leak_area_set = leak_area_set_factor*TRP_Par.Check_Valve.In.Max_Area;
leak_area_set = max(leak_area_set,1e-9); % Leakage area cannot be 0

% Enable Fault as a run time parameter
sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On, Run Time',1);

%% Configure model to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Store simulation inputs
clear simInput
for temp_area_i = 1:length(leak_area_set)
    simInput(temp_area_i) = Simulink.SimulationInput(mdlname);
    simInput(temp_area_i) = ...
        simInput(temp_area_i).setVariable('leak_cyl_area_WKSP',...
        leak_area_set(temp_area_i));
end

%% Run simulation using Fast Restart
simOut = [];
simOut = sim(simInput,'ShowProgress','off','UseFastRestart','on');

%% Disable fault; Undo temporary settings
sm_pump_triplex_config_model(mdlname,'Seal Leak','Off',1);
sm_pump_triplex_config_model(mdlname,'Vis','On');
warning('on','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Get simulation results
t_leakRes = sm_pump_triplex_getMeas(simOut);

%% Reuse figure if it exists, else create new figure
if ~exist('h3_sm_pump_triplex', 'var') || ...
        ~isgraphics(h3_sm_pump_triplex, 'figure')
    h3_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h3_sm_pump_triplex)
clf(h3_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
hold on
for i=1:length(t_leakRes)
    plot(t_leakRes(i).sim.time,t_leakRes(i).sim.qOut,'LineWidth',1);
end
hold off
title('Effect of Increasing Leak Area (% of Max Valve Area)');
ylabel('Flow Rate (lpm)');
xlabel('Time (s)');
grid on

legendstr = string([num2str(leak_area_set_factor'*100)])+'%';
legend(legendstr);

simlog_handles(2) = subplot(2, 1, 2);
hold on
for i=1:length(t_leakRes)
    plot(t_leakRes(i).sim.time,t_leakRes(i).sim.iMotor,'LineWidth',1);
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
