function sm_pump_triplex_winopen_file(filename)
% Function checks if file exists before opening.
% Also adjusts command for Mac or Windows

% Copyright 2016-2020 The MathWorks, Inc.

datasheetUrl = 'http://www.catpumps.com/products/pdfs/1051_C.pdf';

if (exist(filename))
    if(ispc)
        winopen(filename)
    elseif(ismac)
        eval(['!open ' filename]);
    end
elseif(strcmpi(filename,'1051_C.pdf'))
    if(ispc)
        eval(['!start chrome "' datasheetUrl '"']);
    elseif(ismac)
        eval(['!open -a "Google Chrome" ''' datasheetUrl '''']);
    end
else
    msgbox(['File ' filename ' is not on your path.  It may have been excluded to reduce the size of the folder containing all the supporting files for this example.'],'File not provided');
end

