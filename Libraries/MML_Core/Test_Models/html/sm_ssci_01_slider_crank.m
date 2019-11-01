%% Slider-Crank Mechanism with Friction
%
% This example shows a torque-driven slider-crank mechanism driven with
% friction applied at the slider.  The rotational and translational
% Simscape Multibody interface elements provide the connection between the
% 3D mechanical model in Simscape Multibody and the 1D mechanical elements
% in Simscape
% 
% Copyright 2017-2019 The MathWorks, Inc.


%% Model

open_system('sm_ssci_01_slider_crank')

set_param(find_system('sm_ssci_01_slider_crank','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Simulation Results from Simscape Logging
%%
%
% The plot below shows the speed of the crank and slider as the crank
% is driven with a constant torque.
%


sm_ssci_01_slider_crank_plot1speed;

%%

%clear all
close all
bdclose all
