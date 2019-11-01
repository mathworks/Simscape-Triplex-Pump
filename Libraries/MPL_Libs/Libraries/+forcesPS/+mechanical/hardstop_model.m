classdef hardstop_model < int32
    % Enumeration class for hardstop model options.
    
    % Copyright 2017-2019 The MathWorks, Inc.
    
    enumeration
        full_damped_rebound(0)
        smooth_damped_rebound(1)
        full_undamped_rebound(2)
    end
    
methods (Static, Hidden)
    function map = displayText()
        map = containers.Map;
        map('full_damped_rebound') = 'physmod:simscape:library:gui:entries:HardStopFullDampedRebound';
        map('smooth_damped_rebound') = 'physmod:simscape:library:gui:entries:HardStopSmoothDampedRebound';
        map('full_undamped_rebound') = 'physmod:simscape:library:gui:entries:HardStopFullUndampedRebound';
    end
end
end

