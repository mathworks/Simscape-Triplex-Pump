Triplex Pump with Faults
This example models a triplex pump. Three plungers are attached to a single crankshaft 
with crankpins that are 120 degrees out of phase. The result is that at least one chamber 
is always discharging which produces smoother flow than single or duplex pumps.

Mechanical, hydraulic, and electrical parameters are all defined in MATLAB. This lets you 
easily resize the pump. Default parameters are for a CAT Pumps pump model 1051, and the 
STEP file that is used for the housing was downloaded from the CAT Pumps website.

Effects of failing components are included in this example. Degraded behavior due 
to seal leakage, blocked inlets, bearing wear, and broken motor windings can be simulated. 
MATLAB code shows how to accelerate testing by reusing results from previous simulations.

Run startup_sm_pump_triplex.m to begin.

Copyright 2017-2019 The MathWorks, Inc.


