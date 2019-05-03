a = 4.5;
b = 1;
c = 9;

theta = 0:0.001:2*pi;
%r = a + b*cos(c*theta);
r = a + b*(sin(c*theta).^4-0.5);
%r = a + tanh(sin(c*theta));
x = r.*cos(theta);
y = r.*sin(theta);
plot(x,y);
