function [signal freq] = randEEG (frames, epochs, srate, pulse, position,freq)

% function [signal freq] = randEEG (frames, epochs, srate, pulse, position,freq)
%
% Function generates signal as described in the paper of Makinen et al.
% (2005). Namely, it is a sum 4 sinusoids with frequencies chosen randomly
% from range 4-16Hz, with random initial phase. The phase of these
% oscillations is being reset at a specified position.
% Required inputs:
%  frames - number of signal frames per each trial
%  epochs - number of simulated trials
%  srate - sampling rate of simulated signal
%  pulse - boolean that says whether you want a TMS pulse artifact
% Optional input:
%  position - position of the reset [in frames]; default: frames/2 => in the middle
% Output:
%  signal - simulated EEG signal; vector: 1 by frames*epochs containing concatenated trials
% Implemented by: Rafal Bogacz and Nick Yeung, September 2006

if nargin < 5
   position = frames / 2;
end
if nargin < 6
   freqLow = rand(1,20)*20;
   freqHigh = rand(1,10)*50;
   freq = [freqLow freqHigh];
end

%generating the wave
signal = zeros (1, epochs * frames);
for i = 1:length(freq)
    signal = signal + phasereset (frames, epochs, srate, freq(i)+2, abs(freq(i)-2), position);
end

if pulse
    for i = 1:epochs-1
        signal(i*frames+position) = signal(i*frames+position) - 2500;
    end
end
