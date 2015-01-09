function [ pulses] = ft_markpulse( cfg )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

temptrl = cfg.trl;

    pulses(:,1) = temptrl(cfg.trials,1)+cfg.Fs-(cfg.Fs*cfg.prestim);
    pulses(:,2) = temptrl(cfg.trials,1)+cfg.Fs + (cfg.Fs*cfg.poststim);

end

%
% for paired pulse  15ms = 75
%                   25ms = 125
%
%
% for single pulse  15ms = 575
%                   25ms = 625
%