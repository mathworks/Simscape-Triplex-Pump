% Code to sweep inlet port blockage for the triplex pump example and
% plot the results.
%
% Copyright 2017-2022 The MathWorks, Inc.

if (~exist('mdlname','var'))
    mdlname = 'sm_pump_triplex';
end
open_system(mdlname)

%% Test fault combinations
test_set{1} = {'Faults Off','',''};
test_set{2} = {'Seal Leak','on','1'};
test_set{3} = {'Blocked Inlet','on','1'};
test_set{4} = {'Worn Bearing','on',''};
test_set{5} = {'Seal Leak','on','1';'Blocked Inlet','on','1'};
test_set{6} = {'Seal Leak','on','1';'Worn Bearing','on',''};
test_set{7} = {'Blocked Inlet','on','1';'Worn Bearing','on',''};

%{
% Additional diagnostics tests
test_set{8} = {'Seal Leak','on','1';'Blocked Inlet','on','1';'Worn Bearing','on',''};         % 3 faults
test_set{9} = {'Seal Leak','on','1';'Blocked Inlet','on','2';'Worn Bearing','on',''};         % 3 faults, not same
test_set{10} = {'Seal Leak','on','1';'Blocked Inlet','on','2'};                               % not same
test_set{11} = {'Seal Leak','on','1';'Seal Leak','on','2'};                                   % 2 leak
test_set{12} = {'Seal Leak','on','1';'Seal Leak','on','2';'Seal Leak','on','3'};              % 3 leak
test_set{13} = {'Blocked Inlet','on','1';'Blocked Inlet','on','2'};                           % 2 block
test_set{14} = {'Blocked Inlet','on','1';'Blocked Inlet','on','2';'Blocked Inlet','on','3'};  % 3 block
test_set{15} = {'Seal Leak','on','1';'Broken Winding','on',''};                               % S, broken winding
test_set{16} = {'Blocked Inlet','on','1';'Broken Winding','on',''};                           % B, broken winding
test_set{17} = {'Worn Bearing','on','';'Broken Winding','on',''};                             % W, broken winding
%}

%% Configure model to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Run tests
clear legendstr
test_Diag = [];

sm_pump_triplex_config_model(mdlname,'Faults Off');
for i=1:length(test_set)
    testStr = [];
    for j=1:size(test_set{i},1)
        sm_pump_triplex_config_model(mdlname,...
            test_set{i}{j,1},test_set{i}{j,2},test_set{i}{j,3});
        testStr = [testStr test_set{i}{j,1}(1)];
        if(~isempty(test_set{i}{j,3}))
            testStr = [testStr test_set{i}{j,3}(1)];
        end
    end
    simOut(i) = sim(mdlname,'StopTime','1.5');
    testStrSet(i) = cellstr(testStr);
    sm_pump_triplex_config_model(mdlname,'Faults Off');
end
    
%% Disable fault; Undo temporary settings
sm_pump_triplex_config_model(mdlname,'Vis','On');
warning('on','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Reuse figure if it exists, else create new figure
if ~exist('h11_sm_pump_triplex', 'var') || ...
        ~isgraphics(h11_sm_pump_triplex, 'figure')
    h11_sm_pump_triplex = figure('Name', 'sm_pump_triplex');
end
figure(h11_sm_pump_triplex)
clf(h11_sm_pump_triplex)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
test_Diag = sm_pump_triplex_getMeas(simOut);
clear legendstr

% Creating lower subplot first so legend appears in front
% (Legend is associated with upper subplot)
simlog_handles(2) = subplot(2, 1, 2);
hold on
for i=1:length(simOut)
    plot(test_Diag(i).meas.time,test_Diag(i).meas.iMotor,'LineWidth',1);
end
hold off
ylabel('Current (A)');
xlabel('Time (s)');
grid on
box on

simlog_handles(1) = subplot(2, 1, 1);
hold on
for i=1:length(test_Diag)
    plot(test_Diag(i).meas.time,test_Diag(i).meas.qOut,'LineWidth',1);
    logsout_diag = simOut(i).logsout_sm_pump_triplex.get('faultEnumVal');
    legendstr(i) = cellstr(['Test ' num2str(i)  ' (' testStrSet{i} '): ' strrep(char(logsout_diag.Values.Data),'_','\_')]);
end
hold off
title('Diagnostics Test');
ylabel('Flow Rate (lpm)');
grid on
box on


linkaxes(simlog_handles, 'x');

legend(simlog_handles(1),legendstr);

clear simlog_handles temp_colororder 
clear simOut test_Diag
