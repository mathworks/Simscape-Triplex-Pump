% Code to plot simulation results from sm_ssci_hinge_hardstop
% Copyright 2015-2019 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
try
    figure(h1_sm_ssci_hinge_hardstop)
catch
    h1_sm_ssci_hinge_hardstop=figure('Name', 'sm_ssci_hinge_hardstop');
end

% Generate simulation results if they don't exist
if(~exist('simlog_sm_ssci_hinge_hardstop','var'))
    sim('sm_ssci_hinge_hardstop')
end

% Get simulation results
simlog_t = simlog_sm_ssci_hinge_hardstop.Revolute_Joint_FL.Rz.q.series.time;
simlog_qRevFL = simlog_sm_ssci_hinge_hardstop.Revolute_Joint_FL.Rz.q.series.values('deg');
simlog_qRevPS = simlog_sm_ssci_hinge_hardstop.Revolute_Joint_JA.Rz.q.series.values('deg');
simlog_qRevTS = simlog_sm_ssci_hinge_hardstop.Revolute_Joint_TS.Rz.q.series.values('deg');
simlog_qRevJn = simlog_sm_ssci_hinge_hardstop.Revolute_Joint.Rz.q.series.values('deg');
simlog_tStopFL = simlog_sm_ssci_hinge_hardstop.Hard_Stop_FLib.t.series.values('N*m');
simlog_tStopPS = simlog_sm_ssci_hinge_hardstop.Hard_Stop_Friction_JA.Hard_Stop.t.series.values('N*m');
simlog_tStopTS = simlog_sm_ssci_hinge_hardstop.Hard_Stop_Friction_TS.Hard_Stop.t.series.values('N*m');
simlog_tStopJn = simlog_sm_ssci_hinge_hardstop.PS_tll.I.series.values('N*m');

% Plot results
simlog_handles(1) = subplot(2,1,1);
plot(simlog_t,simlog_qRevFL,'LineWidth',4);
hold on
plot(simlog_t,simlog_qRevPS,'LineWidth',2);
plot(simlog_t,simlog_qRevTS,'LineWidth',2,'LineStyle','--');
plot(simlog_t,simlog_qRevJn,'LineWidth',1);
hold off
grid on
title('Comparing Joint Angle');
legend({'Foundation Library','Joint Actuation','Transform Sensor','Joint Limits'},'Location','Best');
ylabel('Angle (deg)');
simlog_handles(2) = subplot(2,1,2);
plot(simlog_t,simlog_tStopFL,'LineWidth',4);
hold on
plot(simlog_t,simlog_tStopPS,'LineWidth',2);
plot(simlog_t,simlog_tStopTS,'LineWidth',2,'LineStyle',':');
plot(simlog_t,-simlog_tStopJn);
hold off
grid on
title('Comparing Limit Torque');
ylabel('Torque (N*m)');
xlabel('Time (s)');

linkaxes(simlog_handles,'x');

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_qRevFL simlog_tStopFL                 
clear simlog_qRevPS simlog_tStopPS                 
clear simlog_qRevTS simlog_tStopTS
