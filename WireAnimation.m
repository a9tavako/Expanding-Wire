function y = WireAnimation(r0,r1, amp0, amp1, OscNum)
%go from r0,amp0 to r1, amp1 in 100 steps. 
ampRes = (amp1 - amp0)/100;
rRes = (r1 - r0)/100;

amp = amp0:ampRes:amp1;
r   = r0:rRes:r1;
for k = 1:length(amp)
    DrawWire(r(k),amp(k),OscNum)
    axis([-r0-r1 r0+r1 -r0-r1 r0+r1])
    len = WireLength(r(k), amp(k), OscNum);
    Area = WireArea(r(k),amp(k),OscNum);
    txt1 = ['Length: ' num2str(len) ' Area:' num2str(Area)];
    txt2 = ['Amp: ' num2str(amp(k)) ' Radius:' num2str(r(k))];
    text(r0+r1-20,r0+r1-10,txt1)
    text(r0+r1-20,r0+r1-5,txt2)
    
    getframe();
end