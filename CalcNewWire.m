function [newLength, newRadius, newArea, newAmp, amp0,goodLengths,goodAmps] = CalcNewWire(length0, radius0, OscNum, areaPrctChange)
%Length0, initial length of the wire.
%Radius0, initial radius of the wire.
%OscNum, num of oscillations.
%Amp is determined by length, radius and OscNum.
%PrctChange, percentage change in area, 4.5 would mean an increase of 4.5%
%in the area. 

%We assume a wire model of the form r = radius + amp*cos(OscNum*theta)
[length0, radius0, amp0] = Calibrate(length0, radius0, OscNum); % finds closest model parameters to the input data.
area0 = WireArea(radius0, amp0, OscNum);
TargetArea = area0 + (areaPrctChange/100)*area0;

if TargetArea > pi*(length0/(2*pi))^2 %more than the area of a perfect circle
    %disp()
    error(areaPrctChange + " too big as percentage change for area. The full expanded wire can't have that much area.")
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

someCounter = 1; %counter for remembering the perfect length combinations. 

minError = radius0^2 + maxamp^2 + area0^2; %initialize to a large value, the expected area is smaller.
bestRadius = 0;
bestAmp = 0;
for k=1:n
    for i= 1:m
        lengths(k,i) = WireLength(r(k),amp(i),OscNum);
        areas(k,i) = WireArea(r(k),amp(i),OscNum);
        errors(k,i) = 1000*abs(lengths(k,i) - length0)^6 + abs(areas(k,i) - TargetArea)^6; %more weight for the length
        if errors(k,i) < minError %select the radius and amp with the smallest error so far.
           %if r(k) == radius0 % skip the case where the radius hasn't changed 
            %   continue;
            %end
            bestRadius = r(k);
            bestAmp = amp(i);
            minError = errors(k,i);
        end
        
        if abs(lengths(k,i) - length0) < 0.9
            goodLengths(someCounter) = r(k);
            goodAmps(someCounter) = amp(i);
            someCounter = someCounter + 1;
        end
    end
end

newRadius = bestRadius;
newAmp = bestAmp;
newLength = WireLength(newRadius, newAmp, OscNum);
newArea = WireArea(newRadius, newAmp, OscNum);

disp(['Original Area: ',num2str(area0)]);
disp(['Target Area: ',num2str(TargetArea)]);
disp(['New area: ',num2str(newArea)]);
disp(['Original radius: ',num2str(radius0)]);
disp(['New radius: ',num2str(newRadius)]);
disp(['Original amp: ',num2str(amp0)]);
disp(['New amp: ',num2str(newAmp)]);
disp(['Original Length: ',num2str(length0)]);
disp(['New length: ',num2str(newLength)]);
disp(['Min Error (delL^2 + delA^2): ',num2str(minError)]);

end

