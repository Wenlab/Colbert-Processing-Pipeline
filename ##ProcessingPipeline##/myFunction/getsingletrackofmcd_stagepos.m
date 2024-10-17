function track=getsingletrackofmcd_stagepos(mcd,startframe,endframe,timegap)

elap1=mcd(startframe).TimeElapsed;
track=[mcd(startframe).StagePosition elap1 mcd(startframe).DLPisOn];
elapi=[];
count = 1;

for i = startframe+1:endframe
    elapi = mcd(i).TimeElapsed;
    if elapi-elap1 >= timegap*count
    track=[track;mcd(i).StagePosition mcd(i).TimeElapsed mcd(i).DLPisOn];
    count=count+1;
    end
end

track=track';
track=track-[track(1:3,1);0];%避免第四行DLP进行减法运算
track(1,:)=track(1,:)*0.05/10^3;
track(2,:)=track(2,:)*0.05/10^3;%1 pixel = 0.05 μm. Here we convert the unit to mm

end