function DrawWire(radius,amp,Oscillations)

thetaRes = 0.001;
theta = 0:thetaRes:2*pi;

r = radius + amp*(sin(Oscillations*theta).^4-0.5);

x = r.*cos(theta);
y = r.*sin(theta);
plot(x,y);
end
