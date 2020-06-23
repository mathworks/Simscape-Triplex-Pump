% Code to plot simulation results from sm_pump_triplex
%% Plot Description:
%
% The plots below show the frequency response of the pump output grouped by
% fault combination.
%
% Copyright 2017-2020 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
if ~exist('h7_sm_pump_triplex', 'var') || ...
        ~isgraphics(h7_sm_pump_triplex, 'figure')
    h7_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h7_sm_pump_triplex)
clf(h7_sm_pump_triplex)

%% Load previously saved results if data not in workspace
if(~exist('test_Results','var') || ~exist('test_Nominal','var') )
    try
        load('sm_pump_triplex_DOEdata')
    catch
        error(['File ''sm_pump_triplex_DOEdata''  is not on your path.  It may have been excluded to reduce the size of the folder containing all the supporting files for this example.'],'File not provided');
    end
end

[freqNom, magNom] = sm_pump_triplex_getFFTData(...
    test_Results(end).meas.time - ...
    test_Results(end).meas.time(1),...
    test_Results(end).meas.pOut);

faultNames = setdiff(unique({test_Results.faults}),'Nominal');
[~, faultNameOrd] = sort(faultNames);
numFaults = length(faultNames);

temp_plot_order = [3 6 1 2 4 5];

for i = 1:numFaults
    fName = faultNames{faultNameOrd(i)};
    simlog_handles(i) = subplot(3,2,temp_plot_order(i));
    title(fName);
    hold on
    tr_ind = find(strcmp({test_Results.faults},fName));
    for tres_i = 1:length(tr_ind)
        [freqFault, magFault] = sm_pump_triplex_getFFTData(...
            test_Results(tr_ind(tres_i)).meas.time - ...
            test_Results(tr_ind(tres_i)).meas.time(1),...
            test_Results(tr_ind(tres_i)).meas.pOut);
        plot(freqFault*60/(2*pi), magFault,'LineWidth',1);
    end
    plot(freqNom*60/(2*pi), magNom,'LineWidth',2,'Color','r');
    grid on
    box on
    %set(gca,'YLim',[0 0.01],'XLim',[0 5000]);
end
hold off
subplot(3,2,1),ylabel('Magnitude');
subplot(3,2,3),ylabel('Magnitude');
subplot(3,2,5),ylabel('Magnitude');
subplot(3,2,5),xlabel('Frequency (Cycles/min)');
subplot(3,2,6),xlabel('Frequency (Cycles/min)');

linkaxes(simlog_handles, 'xy');

clear temp_plot_order numFaults numSimsPerFault
clear simlog_handles
