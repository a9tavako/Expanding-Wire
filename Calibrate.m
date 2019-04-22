function [length0, radius0, bestamp] = Calibrate(length0, radius0, OscNum)
%We assume a wire model of the form r = radius + amp*cos(OscNum*theta)
%Finds closest model parameters to the input data.

ampres = 0.01;
minamp = 0;
maxamp = 0.5*radius0;

%Check difference amps and see which one gives the expected length. 
bestError = radius0^2;
bestamp = 0;
for amp = minamp:ampres:maxamp
    len = WireLength(radius0, amp, OscNum);
    error = (len - length0)^2;
    if error < bestError
        bestamp = amp;
        bestError = error;
    end
end
