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

ind = find(arrayfun(@(n) strcmp(event(n).value, cfg.trialdef.eventvalue), 1:numel(event)));

count = 1;
i     = 1;
j     = 1;

while i <= length(ind)
    j = event(ind(i)).sample-200;
    
        while j <= event(ind(i)).sample+400
            if abs(j-abs(mean(dat(5,j-500:j-300)))) > 1500
                trl(count,1) =  j - offset - cfg.trialdef.prestim*cfg.fs;
                trl(count,2) =  j - offset + cfg.trialdef.poststim*cfg.fs -1;
                trl(count,3) = cfg.trialdef.prestim*5000;
                trl(count,4) = str2double(event(ind(i)).value(4));
                count = count +1;
                j
                break
            else
                display(strcat('***** DID NOT FIND A PULSE AT ', num2str(i), ' *******'));
            end
            
            j = j +1;
        end
    
    i = i +1;
end

clear dat;
end



