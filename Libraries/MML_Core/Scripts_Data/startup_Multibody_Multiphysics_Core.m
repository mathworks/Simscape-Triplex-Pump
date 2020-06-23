function startup_Multibody_Multiphysics_Core
% Copyright 2016-2020 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder);

cd('Libraries')
if(exist('+forcesPS','dir') && ~exist('forcesPS_Lib.slx','file'))
    ssc_build forcesPS
end

MML_libname = 'Multibody_Multiphysics_Lib';
load_system(MML_libname);
MML_ver = get_param(MML_libname,'Description');
disp(MML_ver);
which(MML_libname)

if(curr_proj.Information.TopLevel)
    if (exist('Multibody_Multiphysics_Core_Demo_Script.html','file'))
        web('Multibody_Multiphysics_Core_Demo_Script.html');
    end
end

cd(curr_proj.RootFolder);
