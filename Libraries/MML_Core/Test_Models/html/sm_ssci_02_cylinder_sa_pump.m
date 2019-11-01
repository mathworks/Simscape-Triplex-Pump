%% Single Piston Pump
% 
% This example models a single piston pump.  The rotation of the pump
% crankshaft slides the piston back and forth.  During half of the rotation,
% fluid is drawn through the inlet check valve and out of the tank.  During
% the other half of the rotation, fluid is pushed through the outlet check
% valve and exits the pump.
%
% The piston chamber is modeled with a single-acting hydraulic cylinder.
% The force, position, and velocity are held consistent between the
% hydraulic and mechanical models using physical signal connections.
% 
%
% Copyright 2017-2019 The MathWorks, Inc.



%% Model

open_system('sm_ssci_02_cylinder_sa_pump')

set_param(find_system('sm_ssci_02_cylinder_sa_pump','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Simulation Results from Simscape Logging
%%
%
% The plot below shows the flow rate into and out of the pump.
%


sm_ssci_02_cylinder_sa_pump_plot1qpump;
%%
%
% The plot below shows the volume of the tank.  It decreases with each
% revolution of the pump shaft as fluid is drawn through the inlet check
% valve.
%


sm_ssci_02_cylinder_sa_pump_plot2vtank;

%%

%clear all
close all
bdclose all
