%% Triplex Pump with Faults Overview
%
% <html>
% <tr> This example shows how to develop predictive maintenance algorithms. <br>
% <UL>
% <LI> <a href="matlab:cd(fileparts(which('sm_pump_triplex.slx')));open_system('sm_pump_triplex');">Open Triplex Pump Model</a> (see also model <a href="matlab:web('sm_pump_triplex.html');">documentation</a>) <br>
% <LI> <a href="matlab:edit sm_pump_triplex_DOEdata_process;">Preprocess Measured Data from Pump</a><br>
% <LI> <a href="matlab:edit sm_pump_triplex_fault_detect_algo_design;">Create Training Data and Develop Predictive Maintenance Algorithm</a><br>
% </UL>
% <br>
% <tr>   <img src="sm_triplex_pump_mechExp_NoFaults_small.png" alt="Triplex Pump Image"><br>
% <br>
% <tr><b><u>Model</u></b><br>
% <tr>1.  <a href="matlab:cd(fileparts(which('sm_pump_triplex.slx')));open_system('sm_pump_triplex');">Open Triplex Pump Model</a> (see also model <a href="matlab:web('sm_pump_triplex.html');">documentation</a>) <br>
% <br>
% <tr><b><u>Configure Model</u></b> (<a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Default');">use default</a>)<br>
% <table border=1><tr>
% <td style="text-align:center" colspan=4><b>Set Faults</b></td></tr>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');"><b>All Faults Off</b></a></td>
% <td><b>Plunger 1</b></td>
% <td><b>Plunger 2</b></td>
% <td><b>Plunger 3</b></td></tr>
% <td><b>Seal Leak</b> </td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',1);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',1);">On</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',2);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',2);">On</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','Off',3);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',3);">On</a></td></tr>
% <td><b>Blocked Inlet</b> </td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',1);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',1);">On</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',2);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',2);">On</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','Off',3);">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',3);">On</a></td></tr>
% <td><b>Worn Bearing</b> </td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','Off');">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On');">On</a></td></tr>
% <td><b>Broken Winding</b> </td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Broken Winding','Off');">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Broken Winding','On');">On</a></td></tr>
% </table><br>
% <table border=1><tr>
% <td style="text-align:center" colspan=5><b>Test Diagnostics</b> (<a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Diagnostics','Off');">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Diagnostics','On');">On</a>)</td></tr>
% <td><b>Trained Config</b></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',1);">Leak</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',1);sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',1);">Leak+Block</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',1);sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On');">Leak+Bearing</a></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',1);sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On');">Block+Bearing</a></td></tr>
% <td><b>Untrained Config</b></td>
% <td colspan=2><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','faults off');sm_pump_triplex_config_model('sm_pump_triplex','Seal Leak','On',1);sm_pump_triplex_config_model('sm_pump_triplex','Blocked Inlet','On',1);sm_pump_triplex_config_model('sm_pump_triplex','Worn Bearing','On');">Leak+Block+Bearing</a></td>
% </table><br>
% <table border=1><tr>
% <td><b>Animation</b></td>
% <td><a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Vis','Off');">Off</a>, <a href="matlab:sm_pump_triplex_config_model('sm_pump_triplex','Vis','On');">On</a></td></tr>
% <td><b>Driver</b></td>
% <td><a href="matlab:set_param('sm_pump_triplex/Driver','popup_driver_type','Motor');">Motor</a>, <a href="matlab:set_param('sm_pump_triplex/Driver','popup_driver_type','Dyno');">Dyno</a></td></tr>
% </table><br>
% <tr><b><u>Specification</u></b><br>
% <tr>2.  CAT Pumps Data Sheet: <a href="matlab:sm_pump_triplex_winopen_file('1051_C.pdf');">1051C</a><br>
% <tr>3.  Step File from CAT Pumps: <a href="matlab:sm_pump_triplex_open_system('CAT_Pump_1051C_STEP_file');">Model with STEP file</a><br>
% <tr>4.  SOLIDWORKS model: <a href="matlab:sm_pump_triplex_winopen_file('CAT_Pump_1051.SLDASM');">CAT_Pump_1051.SLDASM</a><br>
% <tr>5.  CAD Import: <a href="matlab:cd(fileparts(which('CAT_Pump_1051.xml')));smimport('CAT_Pump_1051.xml');">Import XML using smimport()</a>, <a href="matlab:sm_pump_triplex_open_system('CAT_Pump_1051_imported');">Imported Model</a><br>
% <br>
% <tr><b><u>Match Nominal Behavior</u></b><br>
% <tr>6.  Tune Parameters: <a href="matlab:sm_pump_triplex_paramest_tune;">Open Tool</a>, <a href="matlab:sm_pump_triplex_paramest_compare;">Compare Results with Initial and Tuned Values</a><br>
% <br>
% <tr><b><u>Design Fault Detection Algorithm</u></b><br>
% <tr>7.  Sweep Severity of Seal Leak: <a href="matlab:sm_pump_triplex_sweep_fault_leak;">Run Sweep</a>, (<a href="matlab:edit sm_pump_triplex_sweep_fault_leak;">see code</a>)<br>
% <tr>8.  Sweep Severity of Blocked Inlet: <a href="matlab:sm_pump_triplex_sweep_fault_blockin;">Run Sweep</a>, (<a href="matlab:edit sm_pump_triplex_sweep_fault_blockin;">see code</a>)<br>
% <tr>9.  Sweep Severity of Bearing Wear: <a href="matlab:sm_pump_triplex_sweep_fault_bearing;">Run Sweep</a>, (<a href="matlab:edit sm_pump_triplex_sweep_fault_bearing;">see code</a>)<br>
% <tr>10. Generate Machine Learning Training Data: <a href="matlab:open_system([bdroot '/Sensing pq Out/Meas Scope/Output Pressure Measurement']);sm_pump_triplex_DOEdata_run(bdroot,'useShort','useSeries','on');">Run Short Sweep</a>, <a href="matlab:sm_pump_triplex_DOEdata_run(bdroot,'useLong','useParallel','on');">Run Long Sweep</a>, (<a href="matlab:edit sm_pump_triplex_DOEdata_run;">see code</a>)<br>
% <tr>11. Design Fault Detection Algorithm: <a href="matlab:edit sm_pump_triplex_fault_detect_algo_design;">Edit Live Script</a><br>
% <tr>12. Test Fault Detection Algorithm: <a href="matlab:sm_pump_triplex_fault_detect_algo_test;">Run 7 Scenarios</a>, (<a href="matlab:edit sm_pump_triplex_fault_detect_algo_test;">see code</a>)<br>
% <br>
% <tr><b><u>Videos</u></b><br>
% <tr>13.  <a href="matlab:sm_pump_triplex_winopen_file('sm_pump_triplex_noFault_16xs_loop_v3.mp4');">Animation of pump</a><br>
% <tr><br>
% </html>
% 
% Copyright 2017-2022 The MathWorks(TM), Inc.
