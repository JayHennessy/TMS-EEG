function [ ft_sampleinfo_var ,wrong] = makeEventNew_12_02_2015( EEG,Fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

i =1;
count = 1;
event_channel = [];
event_pos = [];
wrong = 0;

   while i <= size(EEG.data,2)-510
        
       %Check for single pulse
       if (abs(EEG.data(5,i))>2500)
           
           if max(abs(EEG.data(5,i+500:i+510)))<2000 && max(abs(EEG.data(5,i+55:i+65)))<2000 && min(abs(EEG.data(5,i+20:i+22)))>2000                 
               event_pos(count ,1) = i -6;
               event_pos(count,2) = 1;     %this means its a single
               count = count + 1;
               i = i+15000;
           elseif  max(abs(EEG.data(5,i+502:i+510)))>2000 && max(abs(EEG.data(5,i+58:i+65)))<2000 %&& min(abs(EEG.data(5,i+20:i+22)))>2000   
               event_pos(count ,1) = i -6;
               event_pos(count,2) = 2;     %this means its a double
               count = count + 1;
               i = i+15000;
           elseif max(abs(EEG.data(5,i+502:i+510)))<2000 && max(abs(EEG.data(5,i+58:i+65)))>2000 %&& min(abs(EEG.data(5,i+20:i+22)))>2000   
               event_pos(count ,1) = i -6;
               event_pos(count,2) = 3;     %this means its a icf
               count = count + 1;
               i = i+15000;
           elseif max(abs(EEG.data(5,i+502:i+510)))<2000 && max(abs(EEG.data(5,i+58:i+65)))<2000 && min(abs(EEG.data(5,i+20:i+22)))<2000   
               event_pos(count ,1) = i -6;
               event_pos(count,2) = 4;     %this means its a custom
               count = count + 1;
               i = i+15000;
           else
               %error(' Identified and incorrect event');
               wrong = wrong+1;
           end
       end
        i = i+1;
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
