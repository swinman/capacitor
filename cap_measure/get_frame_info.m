function [line,diff,pos]=get_frame_info(mov,cent_lft,cent_rt,frame)%analyzes one frame of a movie to find position of fluid%inputs the movie file, the left & right sides of the center line%and the frame to analyze%returns the light intensity along the fluid line%returns the difference matrix & the position of the fluidfor i=1:800    center(i)=round(cent_lft+(cent_rt-cent_lft)*(i-1)/799);    line_0(i)=mov(1).cdata(center(i),i);end%finds the range of the tube to analyzefor i=6:794    diff_0(i)=mean(line_0(i+1:i+6))-mean(line_0(i-5:i));end[y,x_start]=max(diff_0(1:490));[y,x_stop]=min(diff_0(350:length(diff_0)));x_stop=x_stop+350;leng=((x_stop-x_start+1)^2+(cent_lft-cent_rt)^2)^(1/2);for i=x_start:x_stop    line(i-x_start+1)=mov(frame).cdata(center(i),i);endfor i=6:leng-6    diff(i)=mean(line(i+1:i+6))-mean(line(i-5:i));end[y,pos]=max(diff);subplot(2,1,1), plot(line(6:length(diff)),'.'), xlabel('position'), ylabel('intensity')subplot(2,1,2), plot(diff(6:length(diff)),'.'), xlabel('position'), ylabel('difference')