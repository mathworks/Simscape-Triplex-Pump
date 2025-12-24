function [test_Nominal, test_Results] = sm_pump_triplex_DOEdata_run(mdlname,setsize,testmode,seemsg)
% Code to generate machine learning training data sets for the triplex pump
% example and plot results.
%
% Copyright 2017-2025 The MathWorks, Inc.

%% Ranges for fault sweep
% Define parameter ranges for tests
numNominal = 5; % Nominal simulations per fault
numParValues = 25;
if (strcmp(setsize,'useShort'))
    numNominal = 0;
    numParValues = 2;
end

% Fault Behavior Sets
fltLeak = linspace(0.018,0.036,numParValues);
fltBlock = linspace(0.5,0.3,numParValues);
fltWear = linspace(3e-4,6e-4,numParValues);

% Variants of Nominal Behavior
nomLeak = linspace(0.00,0.003,numNominal);
nomBlock = linspace(1,0.8,numNominal);
nomWear = linspace(0,5e-5,numNominal);

leak_area_set_factor = [fltLeak nomLeak];
max_valve_area = evalin('base','TRP_Par.Check_Valve.In.Max_Area');
leak_area_set = leak_area_set_factor*max_valve_area;
leak_area_set = max(leak_area_set,1e-9); % Leakage area cannot be 0
blockinfactor_set = [fltBlock nomBlock];
bearingfactor_set = [fltWear nomWear];

% Define time ranges for tests
stopTimeSteadyStateNominal = '0.7';
stopTimeSteadyStateFault   = '1.7';
if (strcmp(setsize,'useShort'))
    stopTimeSteadyStateFault   = '1';
end

% Enable faults for testing; set values for nominal behavior
sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On, Run Time',1);
sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',2);
sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',3);
assignin('base','leak_cyl_area_WKSP',... 
    evalin('base','leak_cyl_area_WKSP_nominal'));

sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On, Run Time',1);
sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',2);
sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',3);
assignin('base','block_in_factor_WKSP',... 
    evalin('base','block_in_factor_WKSP_nominal'));

sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On, Run Time');
assignin('base','bearing_fault_frict_WKSP',... 
    evalin('base','bearing_fault_frict_WKSP_nominal'));

sm_pump_triplex_config_model('sm_pump_triplex','Broken Winding','Off');

% Configure Driver and Diagnostics
set_param([mdlname '/Driver'], 'popup_driver_type', 'Motor');
sm_pump_triplex_config_model('sm_pump_triplex','Diagnostics','Off');


%% Settings to speed up sweep
% Turn off check valve visualization
% Turn off Mechanics Explorer animation
sm_pump_triplex_config_model(mdlname,'Vis','Off');

% Turn off warning concerning Simscape run time parameters
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReference')

%% Configure model to save complete final state
set_param(mdlname,...
    'SaveFinalState','on',...
    'SaveCompleteFinalSimState','on',...
    'LoadInitialState','off',...
    'StopTime',stopTimeSteadyStateNominal,...
    'MaxConsecutiveMinStep','100',...
    'ReturnWorkspaceOutputs','on');

%% Simulate with nominal behavior
simOut = sim(mdlname);

%% Save nominal results
test_Nominal = sm_pump_triplex_getMeas(simOut); 

% Save complete final state
assignin('base','sm_pump_triplex_xFinal_steady_no_fault',simOut.xFinal);
clear simOut

%% Configure model to use pre-saved operating point
%  so that pump starts near operating speed
set_param(mdlname,'SaveFinalState','off',...
    'SaveCompleteFinalSimState','off',...
    'LoadInitialState','on');

% Set Stop time when steady state fault behavior will be reached
set_param(mdlname,'StopTime',stopTimeSteadyStateFault);

%%  Define tests by setting values for fault parameters
% Fault Set 1: Leak cylinder 1
clear simInput
for Ti = 1:numParValues + numNominal
    simInput(Ti) = Simulink.SimulationInput(mdlname);
    simInput(Ti) = simInput(Ti).setVariable('leak_cyl_area_WKSP',leak_area_set(Ti));
end
test_descr = repelem({'Leak P1'},numParValues,1);
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Fault Set 2: Blocked inlet cylinder 1
nTests = length(simInput);
for Ti = 1:numParValues + numNominal
    simInput(nTests+Ti) = Simulink.SimulationInput(mdlname);
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('block_in_factor_WKSP',blockinfactor_set(Ti));
end
test_descr = [test_descr; repmat({'Block P1'},numParValues,1)];
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Fault Set 3: Worn bearing
nTests = length(simInput);
for Ti = 1:numParValues + numNominal
    simInput(nTests+Ti) = Simulink.SimulationInput(mdlname);
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('bearing_fault_frict_WKSP',bearingfactor_set(Ti));
end
test_descr = [test_descr; repmat({'Worn Bearing'},numParValues,1)];
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Fault Set 4: Leak cylinder 1 and blocked inlet 1
nTests = length(simInput);
for Ti = 1:numParValues + numNominal
    simInput(nTests+Ti) = Simulink.SimulationInput(mdlname);
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('leak_cyl_area_WKSP',leak_area_set(Ti));
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('block_in_factor_WKSP',blockinfactor_set(Ti));
end
test_descr = [test_descr; repelem({'Leak P1, Block P1'},numParValues,1)];
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Fault Set 5: Leak cylinder 1 and worn bearing
nTests = length(simInput);
for Ti = 1:numParValues + numNominal
    simInput(nTests+Ti) = Simulink.SimulationInput(mdlname);
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('leak_cyl_area_WKSP',leak_area_set(Ti));
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('bearing_fault_frict_WKSP',bearingfactor_set(Ti));
end
test_descr = [test_descr; repelem({'Leak P1, Worn Bearing'},numParValues,1)];
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Fault Set 6: Blocked inlet 1 and worn bearing
nTests = length(simInput);
for Ti = 1:numParValues + numNominal
    simInput(nTests+Ti) = Simulink.SimulationInput(mdlname);
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('block_in_factor_WKSP',blockinfactor_set(Ti));
    simInput(nTests+Ti) = simInput(nTests+Ti).setVariable('bearing_fault_frict_WKSP',bearingfactor_set(Ti));
end
test_descr = [test_descr; repelem({'Block P1, Worn Bearing'},numParValues,1)];
test_descr = [test_descr; repmat({'Nominal'},numNominal,1)];

% Final run - nominal behavior
nTests = length(simInput);
simInput(nTests+1) = Simulink.SimulationInput(mdlname);
test_descr = [test_descr; {'Nominal'}];

%% Run simulation using Fast Restart
simOut = []; %#ok<NASGU>

% Serial
temp_simtype = 'useSeries';
if (exist('testmode','var'))
    if (strcmp(testmode,'useParallel'))
        temp_simtype = 'useParallel';
    end
end

if(strcmp(temp_simtype,'useParallel'))
    save_system(mdlname);
    simOut = parsim(simInput,'ShowProgress',seemsg,'UseFastRestart','on',...
        'TransferBaseWorkspaceVariables','on');
else
    simOut = sim(simInput,'ShowProgress',seemsg,'UseFastRestart','on');
end

if(isfield(simOut(1),'ErrorMessage'))
    disp(['Error during sweep: ' simOut(1).ErrorMessage']);
end

%% Disable faults; Undo temporary settings
sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',1);
sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',1);
sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','Off');
sm_pump_triplex_config_model(mdlname,'Vis','On');
warning('on','physmod:common:gl:sli:rtp:InvalidNonValueReference');
set_param(mdlname,'SaveFinalState','off',...
    'SaveCompleteFinalSimState','off',...
    'LoadInitialState','off','StopTime','1.5',...
    'MaxConsecutiveMinStep','1',...
    'ReturnWorkspaceOutputs','off');
if(strcmp(temp_simtype,'useParallel'))
    save_system(mdlname);
end

%% Get simulation results
test_Results = sm_pump_triplex_getMeas(simOut);

% Add field with type of fault
for i=1:length(test_Results)
    test_Results(i).faults = test_descr{i};
end

%% Save data
% Remove "sim" field, as only "meas" data is needed for training
test_Nominal = rmfield(test_Nominal,'sim');
test_Results = rmfield(test_Results,'sim');
temp_savefilename = ['sm_pump_triplex_DOEdata_' datestr(now,'yymmdd_HHMM')];
save(temp_savefilename,'test_Nominal','test_Results');

%% Plot time response of different faults
sm_pump_triplex_DOEdata_plot1time

%% Plot frequency response by fault combination
if (~strcmp(setsize,'useShort'))
    sm_pump_triplex_DOEdata_plot2freq
end

