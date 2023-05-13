function shutdown_Multibody_Multiphysics_Core
% Copyright 2016-2023 The MathWorks, Inc.

curr_proj = simulinkproject;
cd(curr_proj.RootFolder);

cd('Libraries')
if(exist('+forcesPS','dir') && exist('forcesPS_Lib.slx','file'))
    ssc_clean forcesPS
end

cd(curr_proj.RootFolder);
