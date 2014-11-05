function [] = getCurve( EEG,zero_point, latency, channel )

%     This function is to see the time course of one channel
%     
%     Inputs:
%         EEG    - this is the EEG variable
%         zero_point  - this is how far off the pulse is from the start of 
%                       each epoch
%         latency     - how long the time course will display
%         channel     - what channel you want to see

%average data
SINGLE = mean(EEG.data,3);



% plot the data from the given 0 point

plot([0:latency], SINGLE(channel,zero_point:(zero_point+latency)));
%title('Average Trial of Channel')
xlabel('time (ms)')
ylabel('uV')

end

