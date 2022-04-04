function sm_pump_triplex_DOEdata_tocsv(test_Data)
% Code to generate measurement data with noise and missing measurements
% from simulation results of sm_pump_triplex.slx
%
% Copyright 2017-2022 The MathWorks, Inc.

% Make data directory if it doesn't exist
if ~exist('Data', 'dir')
    mkdir('Data')
end

list_resFieldNames = fieldnames(test_Data(1).meas);
list_resFieldNames = setdiff(list_resFieldNames,'time');

len_res = length(test_Data(1).meas.time);

idx_1000 = randperm(len_res);
missing_inds = idx_1000(1:10);
keep_inds = setdiff(1:len_res,missing_inds);

noisy_inds = idx_1000(21:30);

% Loop over simOut and write files.
for res_i = 1:numel(test_Data)
    T=table(test_Data(res_i).meas.time+rand(1)*2, 'VariableNames', {'time'});
    test_Data(res_i).meas.pOut(noisy_inds) = 10;
    for field_i = 1:length(list_resFieldNames)
        data_out = test_Data(res_i).meas.(list_resFieldNames{field_i});
        data_out(missing_inds) = NaN;
        T.(list_resFieldNames{field_i}) = data_out;
    end
    T.fault = repelem(test_Data(res_i).faults,height(T),1);
    writetable(T, [pwd filesep 'Data' filesep 'PumpData' num2str(res_i) '.csv'])
end
end
