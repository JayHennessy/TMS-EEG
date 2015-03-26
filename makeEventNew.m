function [ loc wrong w val] = makeEventNew( EEG,Fs,type,location ,channel)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


count = length(type);
event_channel = [];
event_pos = [];
wrong = 1;
j =1;
w=0;
offset = 6;
loc = 1;
while j <= count;
    i = location(j)-100;
    while i <= location(j)+6000
        
        %Check for single pulse
        if (abs(EEG.data(channel,i))>2000)
            val = EEG.data(channel,i);
            event_pos(loc ,1) = i -offset;
            event_pos(loc,2) = type(j);
            break;
        end
        if i > location(j)+5000
            loc = loc -1;
            w(wrong) = j;
            wrong = wrong+1;
            
           % count = count+1;
            break;
        
        end
        i = i+1;
    end
    loc = loc +1;
    j = j+1;
end



ft_sampleinfo_var = zeros(2,size(event_pos,2));

for i = 1:size(event_pos,2)
    
    ft_sampleinfo_var(1,i) = event_pos(i)-1000;
    ft_sampleinfo_var(2,i) = event_pos(i)+1000;
end
ft_sampleinfo_var =ft_sampleinfo_var';

event_pos(:,1) = (event_pos(:,1)./Fs);
%make the event txt file
cd('C:\Users\jay\Desktop\Work\TMS-EEG');
fid = fopen('event.txt', 'wt');
fprintf(fid, 'latency type\n');
for i = 1:length(event_pos)
    fprintf(fid, '%d   S%d\n', event_pos(i,1), event_pos(i,2));
    
end

fclose(fid);
size(event_pos)


end

