% Copyright 2016-2019 The MathWorks, Inc.

SCI_HomeDir = pwd;
addpath(pwd)
addpath(genpath(pwd))

cd Libraries
if((exist('+forcesPS')==7) && ~exist('forcesPS_Lib'))
    ssc_build forcesPS
end
cd ..

SCI_libname = 'Multibody_Multiphysics_Lib';
load_system(SCI_libname);
SPL_ver = get_param(SCI_libname,'Description');
disp(SPL_ver);
which(SCI_libname)


if exist('Multibody_Multiphysics_Demo_Script.html')
    web('Multibody_Multiphysics_Demo_Script.html');
end