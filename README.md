# **Triplex Pump with Faults**
Copyright 2017-2023 The MathWorks(TM), Inc.

![](Scripts_Data/sm_triplex_pump_mechExp_NoFaults_small.png)

This example models a triplex pump. Three plungers are attached to a single crankshaft 
with crankpins that are 120 degrees out of phase. The result is that at least one chamber 
is always discharging which produces smoother flow than single or duplex pumps.

Mechanical, hydraulic, and electrical parameters are all defined in MATLAB. This lets you 
easily resize the pump. Default parameters are for a CAT Pumps pump model 1051, and the 
STEP file that is used for the housing was downloaded from the CAT Pumps website.

Effects of failing components are included in this example. Degraded behavior due 
to seal leakage, blocked inlets, bearing wear, and broken motor windings can be simulated. 
MATLAB code shows how to accelerate testing by reusing results from previous simulations.

Open the project Triplex_Pump.prj to begin.

View on File Exchange: [![View Predictive Maintenance in Hydraulic Pump on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/65605-predictive-maintenance-in-hydraulic-pump)  
You can also open in MATLAB Online: [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Simscape-Triplex-Pump&project=Triplex_Pump.prj)

## **Main Model**
![](Overview/html/sm_pump_triplex_01.png)

## **Mechanical System**
![](Overview/html/sm_pump_triplex_02.png)

## **Piston Chamber**
![](Overview/html/sm_pump_triplex_03.png)

## **Synthetic Data to Train Algorithm**
![](Overview/html/sm_pump_triplex_15.png)