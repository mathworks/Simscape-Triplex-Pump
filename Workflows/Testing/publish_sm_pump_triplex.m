% Script to test sm_triplex_pump and publish html

% Move to directory with publish script
cd(fileparts(which('sm_pump_triplex.slx')));
cd('Overview')

% Find scripts
filelist_m=dir('*.m');
filenames_m = {filelist_m.name};

% Avoid errors and warnings due to shadowed files
bdclose all
warning('off','Simulink:Engine:MdlFileShadowedByFile');

% Publish all scripts
for i=1:length(filenames_m)
    if ~(strcmp(filenames_m{i},'publish_all_html.m'))
    publish(filenames_m{i},'showCode',false)
    end
end

cd(fileparts(which('sm_pump_triplex.slx')));
