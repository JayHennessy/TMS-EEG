function [ activity] = getActivity( EEG )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% tempeeg = abs(EEG.data);
% tempeeg = mean(tempeeg,3);
% activity = sum(tempeeg(5,:));

tempeeg1 = mean(EEG.data,3);
tempeeg = abs(tempeeg1);

activity = sum(tempeeg(5,5250:5750));

plot([0:0.0002:0.15], tempeeg1(5,5000:5750), 'blue')
end

