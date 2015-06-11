function [ trl event ] = jh_trialfun( cfg )
%
% This function takes in a cfg structure and outputs a trl as defined in
% fieldtrip. It should be used as an input as cfg.trialfin = 'jh_trialfun'
% into ft_definetrial
%
% the cfg field must include:
%     cfg.dataset = filename
%     cfg.trialdef.prestim = time in seconds the trial begins before stim
%     cfg.trialdef.poststim = time in seconds the trial ends after stim
%     cfg.trialdef.eventvalue = type of stimulus (eg. 'S  1')
%     
%   note, it will have to be changed if a sample frequency other than 5000 is used
%   
  
offset = 15;
event = ft_read_event(cfg.dataset);
dat = ft_read_data(cfg.dataset);

count = 1;
i     = 1;
j     = 1;

while i <= length(event)
    j = 1;
    if strcmp(event(i).value, cfg.trialdef.eventvalue)
        while j <= event(i).sample+100
            if abs(dat(5,event(i).sample+j)) >2000
                trl(count,1) = event(i).sample + j - offset - cfg.trialdef.prestim*5000;
                trl(count,2) = event(i).sample + j - offset + cfg.trialdef.poststim*5000 -1;
                trl(count,3) = cfg.trialdef.prestim*5000;
                trl(count,4) = str2double(event(i).value(4));
                count = count +1;
                break
            end
            j = j +1;
        end
    end
    i = i +1;
end

clear dat;
end



