function [ ft_sampleinfo_var ] = makeEventNew( EEG,Fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

i =1;
count = 1;
event_channel = [];
event_pos = [];

   while i <= size(EEG.data,2)
        
       %Check for single pulse
       if (abs(EEG.data(5,i))>1000)
           
           if abs(EEG.data(5,i+505))<1000 && abs(EEG.data(5,i+60))<1000 && abs(EEG.data(5,i+18))<1000                 
               event_pos(count ,1) = i -2;
               event_pos(count,2) = 1;     %this means its a single
               count = count + 1;
               i = i+15000;
           elseif  abs(EEG.data(5,i+502))>1000 && abs(EEG.data(5,i+60))<1000 && abs(EEG.data(5,i+18))<1000  
               event_pos(count ,1) = i -2;
               event_pos(count,2) = 2;     %this means its a double
               count = count + 1;
               i = i+15000;
           elseif  abs(EEG.data(5,i+502))<1000 && abs(EEG.data(5,i+60))>1000 && abs(EEG.data(5,i+18))<1000
               event_pos(count ,1) = i -2;
               event_pos(count,2) = 3;     %this means its a icf
               count = count + 1;
               i = i+15000;
           end
       end
        %check for sici pulse
%         if (abs(EEG.data(5,i))>1000) && abs(EEG.data(5,i+505))<1000 && abs(EEG.data(5,i+60))<1000
%             
%             
%             event_pos(count ,1) = i -2;
%             event_pos(count,2) = 1;     %this means its a single
%             count = count + 1;
%             i = i+15000;
%         end
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
