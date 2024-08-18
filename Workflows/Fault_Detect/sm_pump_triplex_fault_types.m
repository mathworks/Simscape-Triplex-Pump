classdef sm_pump_triplex_fault_types < Simulink.IntEnumType
    % Enumeration data for fault types
    %
    % Copyright 2017-2024 The MathWorks, Inc.
    
    enumeration
        FaultDetectOff(0)
        BlockedIn(1)
        BlockedIn_WornBearing(2)
        LeakSeal(3)
        LeakSeal_BlockedIn(4)
        LeakSeal_WornBearing(5)
        Nominal(6)
        WornBearing(7)
    end
end