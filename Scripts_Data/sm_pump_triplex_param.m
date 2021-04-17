%% Triplex Pump Parameters
%
% Copyright 2017-2021 The MathWorks, Inc.

TRP_Par.Material.Steel.rho = 7750;  % kg/m^3

TRP_Par.Spec.target_spd = 958; % rpm
TRP_Par.Spec.p_output   = 7;   % bar
pOut_Init_WKSP          = TRP_Par.Spec.p_output;
TRP_Par.Spec.q_output   = 38;  % lpm

%% Plunger
TRP_Par.Plunger.len     = 0.075;   % m
TRP_Par.Plunger.rad     = 0.024/2;  % m
TRP_Par.Plunger.clr     = [0.4 0.6 0.4];  % RGB
TRP_Par.Plunger.opc     = 1;      % 0-1
TRP_Par.Plunger.rho     = TRP_Par.Material.Steel.rho;

TRP_Par.Seal_Leak.rad = TRP_Par.Plunger.rad*1.001;
TRP_Par.Seal_Leak.len = TRP_Par.Plunger.len*0.05;
TRP_Par.Seal_Leak.clr = [0.9 0.1 0.1];

%% Stem
TRP_Par.Stem.len        = 0.04;   % m
TRP_Par.Stem.rad        = 0.005;  % m
TRP_Par.Stem.clr        = TRP_Par.Plunger.clr;  % RGB
TRP_Par.Stem.opc        = 1;      % 0-1
TRP_Par.Stem.rho        = TRP_Par.Plunger.rho;

% Stem Cup
TRP_Par.StemCup.rad     = 0.015;
TRP_Par.StemCup.wall    = 0.005;
TRP_Par.StemCup.len     = 0.02;
TRP_Par.StemCup.pinOffset  = 0.01;

% Stem Pin
TRP_Par.Pin.len         = TRP_Par.StemCup.rad*2*1.001;   % m
TRP_Par.Pin.rad         = 0.004;  % m
TRP_Par.Pin.opc         = 1;      % 0-1
TRP_Par.Pin.clr         = TRP_Par.Plunger.clr;  % RGB
TRP_Par.Pin.rho         = TRP_Par.Plunger.rho;

%% Crank
TRP_Par.Crank.Cam.rad   = 0.05;   % m
TRP_Par.Crank.Cam.wid   = 0.015;   % m
TRP_Par.Crank.Cam.clr   = [0 0.4 0.6];  % RGB
TRP_Par.Crank.Cam.opc   = 1;  % (0-1)

TRP_Par.Crank.Shaft.rad = 0.03;    % m
TRP_Par.Crank.Shaft.len = 0.046;   % m
TRP_Par.Crank.Shaft.pos = 0.015;   % m
TRP_Par.Crank.Shaft.clr = [0 0.4 0.6];  % RGB
TRP_Par.Crank.Shaft.opc = 1;  % (0-1)
TRP_Par.Crank.rho       = TRP_Par.Material.Steel.rho;

TRP_Par.Crank.Bearing.b = 1e-4;  % N*m/(deg/s)

%% Motor
TRP_Par.Motor.Shaft.len  = 0.07;   % m
TRP_Par.Motor.Shaft.rad  = 0.015;  % m
TRP_Par.Motor.Shaft.clr  = TRP_Par.Crank.Cam.clr*0+[0.5 0.5 0.5];  % RGB
TRP_Par.Motor.Shaft.opc  = 1;      % 0-1
TRP_Par.Motor.Shaft.rho  = TRP_Par.Material.Steel.rho;
TRP_Par.Motor.Gear.ratio = 2;

%% Connecting Rod

TRP_Par.ConRod.len      = 0.0725;   % m
TRP_Par.ConRod.R1.width = TRP_Par.Pin.rad;
TRP_Par.ConRod.R2.width = TRP_Par.ConRod.R1.width;
TRP_Par.ConRod.hei      = TRP_Par.Plunger.rad*0.95;
TRP_Par.ConRod.W1       = TRP_Par.Pin.rad*2;   % m
TRP_Par.ConRod.W2       = TRP_Par.Crank.Shaft.rad/2;   % m
TRP_Par.ConRod.clr      = [0.5 0.5 0.5];  % RGB
TRP_Par.ConRod.opc      = 1;  % (0-1)
TRP_Par.ConRod.rho      = TRP_Par.Material.Steel.rho;

%% Housing
TRP_Par.Plunger.sep     = 0.032;   % m

TRP_Par.Crank.axoffset  =...
    [0 0 ...
    TRP_Par.Plunger.len+TRP_Par.Stem.len+TRP_Par.StemCup.pinOffset+...
    TRP_Par.ConRod.len+...
    TRP_Par.Crank.Shaft.pos];   % m

TRP_Par.Crank.Bearing_sep = 0.2075; % m

TRP_Par.Crank.Bearing_Fault.rad = TRP_Par.Motor.Shaft.rad*1.005; % m
TRP_Par.Crank.Bearing_Fault.len = 0.01; % m
TRP_Par.Crank.Bearing_Fault.clr = [0.9 0.1 0.1]; % m

%% Housing CAD
TRP_Par.CAD.offset    = [0 0 0.2125]; % m

TRP_Par.Housing.clr   = [0.47 0.62 0.82];
TRP_Par.Housing.opc   = 0.2;

TRP_Par.Manifold.clr  = [0.75 0.75 0.75];  % RGB
TRP_Par.Manifold.opc  = 0.2;

TRP_Par.Manifold.Inlet.rad = 0.01; % m

% Obstruction
TRP_Par.Manifold.Inlet.obstr.len = 0.0025; % m
TRP_Par.Manifold.Inlet.obstr.clr = [0.9 0.1 0.1]; % m

%% Cylinder
TRP_Par.Cylinder.len     = TRP_Par.Crank.Shaft.pos*2+TRP_Par.Plunger.len;
TRP_Par.Cylinder.rad_outer = 0.0225; % m
TRP_Par.Cylinder.gap     = 5e-4;  % m
TRP_Par.Cylinder.stroke  = TRP_Par.Crank.Shaft.pos*2;  % m

%TRP_Par.Cylinder.wall    = 1e-2;  % m

TRP_Par.Cylinder.clr     = [0.5 0.5 0.5];  % RGB
TRP_Par.Cylinder.opc     = 0.2;  % RGB
TRP_Par.Cylinder.rho     = TRP_Par.Material.Steel.rho;  % kg/m^3

TRP_Par.Cylinder.Friction.BrkFrc = 2.5*1e-1;
TRP_Par.Cylinder.Friction.BrkVel = 0.1;
TRP_Par.Cylinder.Friction.ColFrc = 2*1e-1;
TRP_Par.Cylinder.Friction.ViscCo = 1*1e-1;

%% Hydraulic Valves
TRP_Par.Check_Valve.In.Max_Area     = 1e-4;  % m^2
TRP_Par.Check_Valve.In.Crack_Pr     = 0.3e5; % Pa
TRP_Par.Check_Valve.In.Max_Open_Pr  = 1.2e5;  % Pa

TRP_Par.Check_Valve.Out.Max_Area    = 1e-4;  % m^2
TRP_Par.Check_Valve.Out.Crack_Pr    = 0.3e5; % Pa
TRP_Par.Check_Valve.Out.Max_Open_Pr = 1.2e5;  % Pa

% Visualization
TRP_Par.Check_Valve.In.Vis.rad  = 0.01;
TRP_Par.Check_Valve.In.Vis.clr  = [0.89 0.85 0.24];
TRP_Par.Check_Valve.Out.Vis.rad = 0.01;
TRP_Par.Check_Valve.Out.Vis.clr = [0.89 0.85 0.24];

%% Sensors
TRP_Par.Sensors.p.Ts = 0.001;
TRP_Par.Sensors.q.Ts = 0.001;
TRP_Par.Sensors.w.Ts = 0.001;
TRP_Par.Sensors.i.Ts = 0.001;

TRP_Par.Sensors.p.Np = 1e-7;  % Units of measured signal are bar
TRP_Par.Sensors.q.Np = 1e-3;  % Units of measured signal are lpm
TRP_Par.Sensors.w.Np = 1e-2;  % Units of measured signal are rpm
TRP_Par.Sensors.i.Np = 1e-5;  % Units of measured signal are A

%% Faults - Run Time Parameters
% Seal Leak
leak_cyl_area_WKSP = TRP_Par.Check_Valve.In.Max_Area*0.03;
leak_cyl_area_WKSP_nominal = 1e-9; % No leak

% Blocked Inlet
block_in_factor_WKSP = 0.5;
chkv_in_maxA_WKSP = TRP_Par.Check_Valve.In.Max_Area;
block_in_factor_WKSP_nominal = 1; % no blockage - 100% open

% Bearing Friction
bearing_visc_frict_WKSP = TRP_Par.Crank.Bearing.b;
bearing_fault_frict_WKSP = 3e-4; % N*m/(deg/s)
bearing_fault_frict_WKSP_nominal = 0; % no additional friction

% Check Valve: Pressure settings for parameter tuning
chkv_all_crkP_WKSP     = TRP_Par.Check_Valve.In.Crack_Pr;
chkv_all_maxOpenP_WKSP = TRP_Par.Check_Valve.In.Max_Open_Pr;

