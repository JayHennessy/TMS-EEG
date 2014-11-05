function [ ft_sampleinfo_var ] = makeEvent( EEG,Fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

i =1;
count = 1;
event_channel = [];
event_pos = [];

   while i <= size(EEG.data,2)
        
        if (EEG.data(5,i)>1500)||EEG.data(5,i)<-1500% && ( -2000<EEG.data(5,i+50)<2000) && ( EEG.data(5,i-15)>-9000) && (EEG.data(5,i+100)<-13000)
            
            
            event_pos(count) = i -12;
            count = count + 1;
            i = i+2000;
        end
        i = i+1;
   end
   
   
ft_sampleinfo_var = zeros(2,size(event_pos,2));

for i = 1:size(event_pos,2)

    ft_sampleinfo_var(1,i) = event_pos(i)-1000;
    ft_sampleinfo_var(2,i) = event_pos(i)+1000;
end
ft_sampleinfo_var =ft_sampleinfo_var';

  event_pos = (event_pos./Fs);
    %make the event txt file
cd('C:\Users\jay\Desktop\Work\TMS-EEG\Programs');
fid = fopen('event.txt', 'wt');
fprintf(fid, 'latency type\n');
for i = 1:length(event_pos)
fprintf(fid, '%d   p-pulse\n', event_pos(i));

end

fclose(fid);
size(event_pos)


end

