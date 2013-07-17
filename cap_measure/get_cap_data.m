function [V,t]=get_cap_data(mov,cent_lft,cent_rt,start,stop,name)%analyzes one frame of a movie to find position of fluid%inputs the movie file, the frames to analyze and the line to analyze%inputs the name of the file to export%returns the light intensity along the fluid line%returns the difference matrix & the position of the fluidline_0=0;dif_0=0;line=0;diff=0;pos=0;t=0;V=0;for i=1:800    center(i)=round(cent_lft+(cent_rt-cent_lft)*(i-1)/799);    line_0(i)=mov(1).cdata(center(i),i);end%finds the range of the tube to analyzefor i=6:794    diff_0(i)=mean(line_0(i+1:i+6))-mean(line_0(i-5:i));end[y,x_start]=max(diff_0(1:490));[y,x_stop]=min(diff_0(350:length(diff_0)));x_stop=x_stop+350;leng=((x_stop-x_start+1)^2+(cent_lft-cent_rt)^2)^(1/2);for fr=start:stop;    for i=x_start:x_stop        line(i-x_start+1)=mov(fr).cdata(center(i),i);    end    for i=6:leng-6        diff(i)=mean(line(i+1:i+6))-mean(line(i-5:i));    end    [y,pos(fr-start+1)]=max(diff);end%biggest capilary%capilary_volume=50;     %volume of capilary (uL)%capilary_length=72.5;   %lenght of calibrated capilary (mm)%measure_length=10.2;    %length of measurement section in capilary (mm)%large capilary%capilary_volume=10;     %volume of capilary (uL)%capilary_length=50.5;   %lenght of calibrated capilary (mm)%measure_length=25;    %length of measurement section in capilary (mm)%small capilarycapilary_volume=5;     %volume of capilary (uL)capilary_length=54.75;   %lenght of calibrated capilary (mm)measure_length=49;    %length of measurement section in capilary (mm)length_2_vol=capilary_volume/capilary_length;calib=measure_length/leng*length_2_vol;t=1:length(pos);        %time in mst=t*10^-3;              %time in sV=pos*calib;            %volume ouptut in uLflow=V(length(V))/t(length(V))*60*10^-3dlmwrite(name,[t' V'],'\t')plot(t,V,'.'), xlabel('time (ms)'), ylabel('volume (uL)')