function [ CI ] = ci_measure( EEG_lici, EEG_single, channel)
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


p = abs(EEG_lici.data);
s = abs(EEG_single.data);


EEG_px = mean(p,3);
EEG_sx = mean(s,3)

EEG_p = EEG_px(channel, tp);
EEG_s = EEG_sx(channel, ts);



%plot the averaged rectified curve
figure('name','Paired (blue) and Single (red)');
plot(t, EEG_p,'blue', t,EEG_s, 'red');



%find the area under the curve
paired = sum(sum(EEG_p));
single = sum(sum(EEG_s));

%calculate cortical inhibition
CI = (1- (paired/single))*100;

fprintf(' The percent of cortical inhibition is: %.1f %% \n', CI);


end

