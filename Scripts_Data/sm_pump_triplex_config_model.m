function sm_pump_triplex_config_model(mdlname, config_option, varargin)
% Function to configure sm_pump_triplex
%
% Copyright 2017-2018 The MathWorks, Inc.

if(nargin>=3)
    onOff = varargin{1};
    plunger_num = -1;
end
if(nargin>=4)
    plunger_num = varargin{2};
end

switch lower(config_option)
    case 'default'
        disable_faults(mdlname)
        set_visualization(mdlname,'On')
        set_param([mdlname '/Driver'],'popup_driver_type','Motor');
        set_param([mdlname '/Diagnostics'],'popup_fault_diagnostics','On');
        set_param([mdlname '/Pump'],'chkv_press_set_popup_P','Set in Mask');
        evalin('base','sm_pump_triplex_param');
        close_system([mdlname '/Sensing pq Out/Compare/Output Pressure'],0);
        close_system([mdlname '/Sensing pq Out/Meas Scope/Output Pressure Measurement'],0);
        close_system([mdlname '/pOut'],0);
        set_param(mdlname,'StopTime','1.5');
        set_param(mdlname,'FastRestart','Off');
        set_param(mdlname,'SaveFinalState','off',...
            'SaveCompleteFinalSimState','off',...
            'LoadInitialState','off',...
            'MaxConsecutiveMinStep','1',...
            'ReturnWorkspaceOutputs','off');
    case {'seal leak','blocked inlet','worn bearing','broken winding'}
        set_fault(mdlname,config_option,plunger_num,onOff)    
    case 'faults off'
        disable_faults(mdlname)
    case 'vis'
        set_visualization(mdlname,onOff)
    case 'diagnostics'
        set_diagnostics(mdlname,onOff)
end
end

function disable_faults(mdlname)
set_param([mdlname '/Pump'],'leak_cyl1_popup','Off','leak_cyl2_popup','Off','leak_cyl3_popup','Off');
set_param([mdlname '/Pump'],'block_in_cyl1_popup','Off','block_in_cyl2_popup','Off','block_in_cyl3_popup','Off');
set_param([mdlname '/Pump'],'bearing_fault_popup','Off');
set_param([mdlname '/Driver'],'winding_fault_enable_P','Off')
end


function set_fault(mdlname,fault_type,plunger_num,onOff)

motor_fault_field = 'none';
switch lower(fault_type)
    case 'seal leak'
        pump_fault_field = ['leak_cyl' num2str(plunger_num) '_popup'];
    case 'blocked inlet'
        pump_fault_field = ['block_in_cyl' num2str(plunger_num) '_popup'];
    case 'worn bearing'
        pump_fault_field = 'bearing_fault_popup';
    case 'broken winding'
        pump_fault_field = 'none';
        motor_fault_field = 'winding_fault_enable_P';
    otherwise
        disp(['Fault ' fault_type ' not known']);
end

if(~strcmp(pump_fault_field,'none'))
    set_param([mdlname '/Pump'],pump_fault_field,onOff);
end

if(~strcmp(motor_fault_field,'none'))
    set_param([mdlname '/Driver'],motor_fault_field,onOff);
end

end

function set_visualization(mdlname,onOff)
    set_param(mdlname,'SimMechanicsOpenEditorOnUpdate',onOff);
    set_param([mdlname '/Pump'], 'chkv_vis_popup_P',onOff);
end

function set_diagnostics(mdlname,onOff)
    set_param([mdlname '/Diagnostics'], 'popup_fault_diagnostics',onOff);
end
