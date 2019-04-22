length0 = 225;
radius0 = 15;
OscNum = 20;
AreaPectChange = 4.5;

[newLength, newRadius, newArea, newAmp, originalAmp] = CalcNewWire(length0, radius0, OscNum, AreaPectChange);
WireAnimation(radius0, newRadius, originalAmp, newAmp, OscNum);
