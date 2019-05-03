function wirelength = WireLength(a,b,c)
delTheta = 0.01;
theta = 0:delTheta:2*pi;
r = a + b*(sin(c*theta).^4-0.5);

% polar arc length formula is integral sqrt(r^2+r'^2)
% numerically it is the same as  sqrt((delta-theta)^2*r^2 + (delta r)^2)
deltaR = zeros(1,length(r));
for k=1:length(r)-1
    deltaR(k) = r(k+1) - r(k);
end
deltaR(end) = r(1) - r(end);

%numerical integration
wirelength = sum(sqrt(delTheta^2*r.^2 + deltaR.^2));
end

