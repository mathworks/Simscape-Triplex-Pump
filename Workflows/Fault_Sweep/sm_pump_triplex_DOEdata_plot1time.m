% Code to plot time domain results of training runs for the triplex pump
% example
%
% Copyright 2017-2022 The MathWorks, Inc.

%% Reuse figure if it exists, else create new figure
if ~exist('h6_sm_pump_triplex', 'var') || ...
        ~isgraphics(h6_sm_pump_triplex, 'figure')
    h6_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h6_sm_pump_triplex)
clf(h6_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

%% Load previously saved results if data not in workspace
if(~exist('test_Results','var') || ~exist('test_Nominal','var') )
    try
        load('sm_pump_triplex_DOEdata')
    catch
        error(['File ''sm_pump_triplex_DOEdata''  is not on your path.  It may have been excluded to reduce the size of the folder containing all the supporting files for this example.'],'File not provided');
    end
end

%% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(test_Nominal.meas.time,test_Nominal.meas.pOut,'LineWidth',1);
hold on

%res_inds = find(strcmp({test_Results.faults},'Worn Bearing'));
tr_inds = find(~strcmp({test_Results.faults},'Nominal'));

for i=1:length(tr_inds)
    plot(...
        test_Results(tr_inds(i)).meas.time,...
        test_Results(tr_inds(i)).meas.pOut,'LineWidth',1);
end
hold off

title('Sweep Test of Faults (Individual and Combination)');
ylabel('Output (bar)');
grid on

simlog_handles(2) = subplot(2, 1, 2);
plot(test_Nominal.meas.time,test_Nominal.meas.iMotor,'LineWidth',1);
hold on
for i=1:length(tr_inds)
    plot(...
        test_Results(tr_inds(i)).meas.time,...
        test_Results(tr_inds(i)).meas.iMotor,'LineWidth',1);
end
hold off

ylabel('Current (A)');
xlabel('Time (s)');
grid on

linkaxes(simlog_handles(1:2), 'x');
