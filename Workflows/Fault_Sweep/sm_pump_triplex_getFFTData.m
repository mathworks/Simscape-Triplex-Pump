function [freq, mag] = sm_pump_triplex_getFFTData(tout,yout)
% Code to calculate frequency response data
%
% Copyright 2017-2024 The MathWorks, Inc.

% Interpolate onto periodic time base
np = 2^floor(log(numel(tout))/log(2));
dt = tout(end)/(np-1);
tout_intp = 0:dt:tout(end);
yout_intp = interp1(tout,yout,tout_intp,'linear');

% Compute fft
yout_intp = yout_intp(:).*hamming(np);
f = fft(yout_intp)/np;
f2 = f(1:(np/2)+1);
w = (0:np/2)/np*(2*pi/dt);
P = abs(f2);
ind = 20<w & w<500; % Between 20 & 350 radians/sec
freq = w(ind)';
mag = P(ind);
end