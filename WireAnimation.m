function y = WireAnimation(r0,r1, amp0, amp1, OscNum)
framSize = 15;

%go from r0,amp0 to r1, amp1 in 100 steps. 
ampRes = (amp1 - amp0)/100;
rRes = (r1 - r0)/100;

amp = amp0:ampRes:amp1;
r   = r0:rRes:r1;
for k = 1:length(amp)
    DrawWire(r(k),amp(k),OscNum)
    axis([-1*framSize framSize -1*framSize framSize])
    
    
    len = WireLength(r(k), amp(k), OscNum);
    len = round(len,3,'significant');
    
    Area = WireArea(r(k),amp(k),OscNum);
    Area = round(Area,3,'significant');
    
    amp(k) = round(amp(k),3,'significant');
    r(k)   = round(r(k),3,'significant');
    
    txt1 = ['Length: ' num2str(len) ];
    txt2 = ['Radius: ' num2str(r(k)) ];
    txt3 = ['Amp:    ' num2str(amp(k)) ];
    txt4 = ['Area:   ' num2str(Area)  ];
    text(-framSize,1,txt1);
    text(-framSize,4,txt2);
    text(-framSize,7, txt3);
    text(-framSize,10, txt4);
    
    F(k) = getframe(gcf);
end

writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = 10;
open(writerObj);
for i=1:length(F)
    frame = F(i) ;    
    writeVideo(writerObj, frame);
end
close(writerObj);
