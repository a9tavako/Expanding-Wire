function DrawWire(a,b,c)
r = a;
amp = b;
Oscillations = c;

thetaRes = 0.001;
theta = 0:thetaRes:2*pi;

r = a + amp*cos(Oscillations*theta);
x = r.*cos(theta);
y = r.*sin(theta);
plot(x,y);
end
