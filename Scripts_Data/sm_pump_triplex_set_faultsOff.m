% Code to set model sm_pump_triplex back to defaults
%
% Copyright 2017-2019 The MathWorks, Inc.

set_param([bdroot '/Pump'],'leak_cyl1_popup','Off','leak_cyl2_popup','Off','leak_cyl3_popup','Off');
set_param([bdroot '/Pump'],'block_in_cyl1_popup','Off','block_in_cyl2_popup','Off','block_in_cyl3_popup','Off');
set_param([bdroot '/Pump'],'bearing_fault_popup','Off');
set_param([bdroot '/Driver'],'winding_fault_enable_P','Off');
