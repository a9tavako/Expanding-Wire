radiusMin = 10;
radiusMax = 20;
radiusRes = 0.05;
minAmp = 0;
maxAmp = 5;
ampInc = 0.05;
osciNum = 20;

L0 = 200;
A0 = 900;

r   = radiusMin:radiusRes:radiusMax;
amp = minAmp:ampInc:maxAmp;
n = length(r);
m = length(amp);
lengths = zeros(n,m);
Areas = zeros(n,m);
Errors = zeros(n,m);
minError = 100; %initialize to a large value;
bestR = 0;
bestAmp = 0;
for k=1:n
    for i= 1:m
        %k,i
        lengths(k,i) = WireLength(r(k),amp(i),osciNum);
        Areas(k,i) = WireArea(r(k),amp(i),osciNum);
        Errors(k,i) = abs(lengths(k,i) - L0)^2 + abs(Areas(k,i) - A0)^2;
        if Errors(k,i) < minError
            bestR = r(k);
            bestAmp = amp(i);
            minError = Errors(k,i);
        end
    end
end
f1 = figure();
[X,Y] = meshgrid(amp,r);
[C,h] = contour(X,Y,lengths);
clabel(C,h);
title('lenghts');

f23 = figure();
[C,h] = contour(X,Y,Areas);
clabel(C,h);
title('Areas');



