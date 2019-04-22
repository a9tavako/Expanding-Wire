function lenght = WireLengthManual(a,b,c)
delTheta = 0.01;
theta = 0:delTheta:2*pi;
func = ( (a+b*cos(c.*theta)).^2 + (b*c*sin(c.*theta)).^2 ).^(0.5);
lenght = delTheta* sum(func(1:end-1));
end

