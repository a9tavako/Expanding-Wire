function y = WireArea2(a,b,c)
if c == 0
    y = (a+b)^2*pi;
    return;
end
y = pi*a^2 + pi*b^2/2 + a*b*sin(2*pi*c)/c + b^2/(8*c)*sin(4*c*pi);
end