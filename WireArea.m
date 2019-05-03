function area = WireArea(a,b,c)

delTheta = 0.01;
theta = 0:delTheta:2*pi;
r = a + b*(sin(c*theta).^4-0.5);

%polar area equation int (1/2)r^2
r = r(1:end-1); %need to exclude the last number for integration. 
area = (0.5)* sum(r.^2)*delTheta;
end