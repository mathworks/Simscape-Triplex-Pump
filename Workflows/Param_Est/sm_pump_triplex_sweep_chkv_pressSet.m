% Code to sweep check valve pressure settings for the triplex pump
% example and plot results.
%
% Copyright 2017-2025 The MathWorks, Inc.

mdlname =  'sm_pump_triplex';
crp_set = linspace(30000,100000,8);
mxp_set = linspace(120000,120000*2,10);

set_param([mdlname '/Driver'],'popup_driver_type','Dyno');
set_param([mdlname '/Pump'],'chkv_press_set_popup_P','Tune at Run Time');
set_param(mdlname,'StopTime','0.2');

%% Store simulation inputs
clear simInput
run_num = 0;
for ci= 1:length(crp_set)
    for mi = 1:length(mxp_set)
        if (mxp_set(mi)>crp_set(ci))
            run_num = run_num+1;
            simInput(run_num) = Simulink.SimulationInput(mdlname);
            simInput(run_num) = ...
                simInput(run_num).setVariable('chkv_in_crkP_WKSP',...
                crp_set(ci));
            simInput(run_num) = ...
                simInput(run_num).setVariable('chkv_out_crkP_WKSP',...
                crp_set(ci));
            simInput(run_num) = ...
                simInput(run_num).setVariable('chkv_in_maxOpenP_WKSP',...
                mxp_set(mi));
            simInput(run_num) = ...
                simInput(run_num).setVariable('chkv_out_maxOpenP_WKSP',...
                mxp_set(mi));
        end
    end
end

%% Run tests
simOut = sim(simInput,'ShowProgress','on','UseFastRestart','on');

%% Get and plot results
run_num = 0;
clear simlog_test
for ci= 1:length(crp_set)
    for mi = 1:length(mxp_set)
        if (mxp_set(mi)>crp_set(ci))
            run_num = run_num+1;
            simlog_run = simOut(run_num).simlog_sm_pump_triplex;
            simlog_test(run_num).t = simlog_run.Pump.Plunger_1.Check_Valve_Outlet.q_A.series.time;
            simlog_test(run_num).q1 = simlog_run.Pump.Plunger_1.Check_Valve_Outlet.q_A.series.values('lpm');
            simlog_test(run_num).q2 = simlog_run.Pump.Plunger_2.Check_Valve_Outlet.q_A.series.values('lpm');
            simlog_test(run_num).q3 = simlog_run.Pump.Plunger_3.Check_Valve_Outlet.q_A.series.values('lpm');
            simlog_test(run_num).qA = simlog_run.Sensing_pq_Out.Flow_Rate_Sensor.V.series.values('lpm');
            simlog_test(run_num).wP = simlog_run.Pump.Crank_Bearing.Rz.w.series.values('rpm');
            simlog_test(run_num).crp = crp_set(ci);
            simlog_test(run_num).mxp = mxp_set(mi);
        end
    end
end

%% Plot Results
if ~exist('h9_sm_pump_triplex', 'var') || ...
        ~isgraphics(h9_sm_pump_triplex, 'figure')
    h9_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h9_sm_pump_triplex)
clf(h9_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot simulation results

%hold on
numplots = 0;
for i=1:length(simlog_test)
    numplots = numplots+1;
    simlog_t = simlog_test(i).t;
    simlog_q1 = simlog_test(i).q1;
    simlog_q2 = simlog_test(i).q2;
    simlog_q3 = simlog_test(i).q3;
    simlog_qA = simlog_test(i).qA;
    
    simlog_wP = simlog_test(i).wP;
    
    % Plot results
    simlog_handles(1) = subplot(2, 1, 1);
    hold on
    plot(simlog_t, simlog_qA,'LineWidth', 1)
    simlog_handles(2) = subplot(2, 1, 2);
    plot(simlog_t, simlog_wP, 'LineWidth', 1)
    hold on
    legendstr{numplots} = ['crp ' num2str(floor(simlog_test(i).crp)) '; mxp ' num2str(floor(simlog_test(i).mxp))];
end

simlog_handles(1) = subplot(2, 1, 1);hold off; box on
legend(legendstr)
title('Volumetric Flow Rate at Output')
ylabel('Flow Rate (lpm)')
simlog_handles(2) = subplot(2, 1, 2);hold off; box on
title('Speed (rpm)')
grid on

set_param([mdlname '/Driver'],'popup_driver_type','Motor');
set_param([mdlname '/Pump'],'chkv_press_set_popup_P','Set in Mask');
set_param(mdlname,'StopTime','0.7');
