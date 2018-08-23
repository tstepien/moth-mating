x = linspace(0,500,50);
y = linspace(-50,50,10);
times = 1:7200;

[Xcoord,Ycoord] = meshgrid(x,y);

plume = zeros(length(x),length(y),length(times));

for k = times
      % plume(i,j,k) = odorFunTime_strategy(x(i),y(j),times(k),X.interval,X.Q,500);
      plume(:,:,k) = odorFunTime_strategy(Xcoord',Ycoord',times(k),X.interval,X.Q,500);
end

videos=VideoWriter('myFile','MPEG-4');
videos.FrameRate = 30;
videos.Quality = 100;
open(videos)

for k = times
    surf(plume(:,:,k))
    title(['t= ',num2str(k)])
    frame = getframe(gcf);
    writeVideo(videos,frame)
end

close(videos)
