function lib( libInfo )
% Customize library
% Copyright 2005-2022 The MathWorks, Inc

libInfo.Name = 'Simscape Forces Library';
CurrentDate = date;
CurrentYear = CurrentDate(end-3:end);
libInfo.Annotation = sprintf('%s\n%s','Simscape Forces Library',['Copyright 2016-' CurrentYear ' The ' 'Math' 'Works, ' 'Inc']);
end
