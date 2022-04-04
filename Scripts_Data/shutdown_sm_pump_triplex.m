% Shutdown file for triplex pump example
%
% Copyright 2017-2022 The MathWorks, Inc.

cd(fileparts(which('sm_pump_triplex_DOEdata_tocsv.m')));
cd('Data');
delete('*.csv');

cd(fileparts(which('sm_pump_triplex.slx')));
