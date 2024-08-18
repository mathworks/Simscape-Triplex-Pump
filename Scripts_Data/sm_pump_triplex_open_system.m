function sm_pump_triplex_open_system(filename)
% Function checks if file exists before opening.
% Also adjusts command for Mac or Windows

% Copyright 2016-2024 The MathWorks, Inc.

if (exist(filename,'file'))
    open_system(filename)
else
    msgbox(['File ' filename ' is not on your path.  It may have been excluded to reduce the size of the folder containing all the supporting files for this example.'],'File not provided');
end

