function [ CI, stat ] = ci_measure( EEG_lici, EEG_single, channel,band)
%
%  [ CI ] = ci_measure( EEG_lici, EEG_single)
%
% ci_measure measures the cortical inhibition of a given eeg dataset by
% comparing the averaged paired pulse post stimulus data to the averaged 
% sinlge pulse post stimulus data. In this case it compares 50 - 150 ms 
% post stimulus. The channel is the channel EEG electrode channel you want
% to look at. Note: the eeg data should be already processed and epoched
%
%


% times = 6000;
% ts = [5075:times];
% timep = 6500;
% tp = [5575:timep];

times = 5750;
ts = [5250:times];
timep = 6250;
tp = [5750:timep];

t = [0.050:0.0002:0.15];
%rectify the curve between 50-150 ms  post stimulus


EEG_px = mean(EEG_lici.data,3);
EEG_sx = mean(EEG_single.data,3);


p = abs(EEG_px);
s = abs(EEG_sx);

EEG_p = p(channel, tp);
EEG_s = s(channel, ts);

for i = 1:size(EEG_p,2)

    X(1) = EEG_p(i);
    X(2) = EEG_s(i);
    
end

stat =0;
%stat = anova1(X');

%plot the averaged rectified curve
%figure('name','Paired (blue) and Single (red)');
figure
plot(t, EEG_p,'blue', t,EEG_s, 'red');
title(strcat('Paired Pulse Vs Single Pulse in the ', band));    
ylabel('Potential (uV)');
xlabel('Time (s)');
legend('Paired Pulse', 'Single Pulse');



%find the area under the curve
paired = sum(sum(EEG_p));
single = sum(sum(EEG_s));

%calculate cortical inhibition
CI = (1- (paired/single))*100;

fprintf(' The percent of cortical inhibition in %5s is: %.1f %% \n', band, CI);


end

