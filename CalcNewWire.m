function [newLength, newRadius, newArea, newAmp, amp0] = CalcNewWire(length0, radius0, OscNum, areaPrctChange)
%Length0, initial length of the wire.
%Radius0, initial radius of the wire.
%OscNum, num of oscillations.
%Amp is determined by length, radius and OscNum.
%areaPrctChange, percentage change in area, should be between -0.99 and 0.99. 

%We assume a wire model of the form r = radius + amp*cos(OscNum*theta)
[length0, radius0, amp0] = Calibrate(length0, radius0, OscNum); % finds closest model parameters to the input data.
area0 = WireArea(radius0, amp0, OscNum);
TargetArea = area0 + areaPrctChange*area0;

if TargetArea > pi*(length0/(2*pi))^2 %more than the area of a perfect circle
    disp(areaPrctChange + " too big as percentage change for area.")
    return;
end



minRadius = radius0*0.5; % need to make choices for param ranges; percentage of radius gives flexibility.
maxRadius = 1+ length0/(2*pi); % a perfect circle has this radius minus 1
radiusRes = radius0*0.01;

minamp = 0;
maxamp = radius0*0.5;
ampRes = 0.01;

%We iteratate over the possible values of radius and amp, looking for the
%best match with the length and area inputs.
r   = minRadius:radiusRes:maxRadius;
amp = minamp:ampRes:maxamp;
n = length(r);
m = length(amp);
lengths = zeros(n,m);
areas = zeros(n,m);
errors = zeros(n,m);

minError = radius0^2 + maxamp^2; %initialize to a large value, the expected area is smaller.
bestRadius = 0;
bestAmp = 0;
for k=1:n
    for i= 1:m
        lengths(k,i) = WireLength(r(k),amp(i),OscNum);
        areas(k,i) = WireArea(r(k),amp(i),OscNum);
        errors(k,i) = abs(lengths(k,i) - length0)^2 + abs(areas(k,i) - TargetArea)^2;
        if errors(k,i) < minError %select the radius and amp with the smallest error so far.
            bestRadius = r(k);
            bestAmp = amp(i);
            minError = errors(k,i);
        end
    end
end

newRadius = bestRadius;
newAmp = bestAmp;
newLength = WireLength(newRadius, newAmp, OscNum);
newArea = WireArea(newRadius, newAmp, OscNum);
end

