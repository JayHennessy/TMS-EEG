function [ pulses] = ft_markpulse( cfg )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% if cfg.type == 2
%     
%     
%     pulses = zeros(length(cfg.trials),2);
%     
%     for i = 1:length(cfg.trials)
%         x = 2*i-1;
%         pulses(i,1) = (x-1)*2*cfg.Fs + cfg.Fs - (cfg.Fs*cfg.prestim);
%         pulses(i,2) = (x-1)*2*cfg.Fs + cfg.Fs + (cfg.Fs*cfg.poststim);
%         
%     end
%     
% else
    pulses = zeros(length(cfg.trials),2);
    
    for i = 1:length(cfg.trials)
        
        pulses(i,1) = (i-1)*2*cfg.Fs + cfg.Fs - (cfg.Fs*cfg.prestim);
        pulses(i,2) = (i-1)*2*cfg.Fs + cfg.Fs + (cfg.Fs*cfg.poststim);
        
    end
% end

%
% for paired pulse  15ms = 75
%                   25ms = 125
%
%
% for single pulse  15ms = 575
%                   25ms = 625
%