length0 = 77;
radius0 = 4.5;
OscNum = 9; % get's multiplied by 2, OscNum 9 gives 18 peaks. 
AreaPectChange = 400; % 4.5 means 4.5% increase in the area. 

[newLength, newRadius, newArea, newAmp, originalAmp, goodLengths, goodAmps] = CalcNewWire(length0, radius0, OscNum, AreaPectChange);
WireAnimation(radius0, newRadius, originalAmp, newAmp, OscNum);
