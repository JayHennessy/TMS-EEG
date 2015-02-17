function [ j ] = makeEventNew( EEG,Fs,type,location )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


count = 1;
event_channel = [];
event_pos = [];
wrong = 0;
j =1;

while j <= length(type);
    i = location(j)-50;
    while i <= size(EEG.data,2)-510
        
        %Check for single pulse
        if (abs(EEG.data(5,i))>2500)
            
            
            event_pos(j ,1) = i -6;
            event_pos(j,2) = type(j);
            break;
        end
        i = i+1;
    end
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

