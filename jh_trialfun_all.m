function [ trl event ] = jh_trialfun_all( cfg )
%
% This function takes in a cfg structure and outputs a trl as defined in
% fieldtrip. It should be used as an input as cfg.trialfin = 'jh_trialfun'
% into ft_definetrial. it is different from jh_trialfun in that it selects
% all the triggers not just a specific type.
%
% the cfg field must include:
%     cfg.dataset = filename
%     cfg.trialdef.prestim = time in seconds the trial begins before stim
%     cfg.trialdef.poststim = time in seconds the trial ends after stim
%     cfg.trialdef.eventvalue = type of stimulus (eg. 'S  1')
%     cfg.fs                = sampling frequency (usually 5000)
%     
%   note, it will have to be changed if a sample frequency other than 5000 is used
%   
  
offset = 5;
event = ft_read_event(cfg.dataset);
dat = ft_read_data(cfg.dataset);

%ind = find(arrayfun(@(n) strcmp(event(n).value(1:2), 'S '), 1:numel(event)));
ind = find(arrayfun(@(n) ischar(event(n).value), 1:numel(event)));

count = 1;
i     = 2;
j     = 1;
count3 =1;
latency = zeros(1,length(ind));

while i <= length(ind)
    j = event(ind(i)).sample-200;
    count2 =1;
    mean_val1 = mean(dat(5,j-300:j));
    mean_val2 = mean(dat(49,j-300:j));
    
        while j <= event(ind(i)).sample+400
            count2 = count2+1;
        
            if (abs(dat(5,j)- mean_val1) > 200 ) || (abs(dat(49,j)- mean_val2) > 200) %&& (event(ind(i)).value(4)<5)
            % if dat(5,j)>2500
                trl(count,1) =  j - offset - cfg.trialdef.prestim*cfg.fsample;
                trl(count,2) =  j - offset + cfg.trialdef.poststim*cfg.fsample -1;
                trl(count,3) = -cfg.trialdef.prestim*cfg.fsample;
                trl(count,4) = str2double(event(ind(i)).value(4));
                count = count+1;
                  latency(count) = count2;
                  temp1(count3)=dat(5,j);
                  temp2(count3)=mean_val1;
                  count3=count3+1;
                break
            elseif j == event(ind(i)).sample+399
                temp1(count3)=dat(5,j-170);
                temp2(count3)=mean_val1;
                count3=count3+1;
                display(strcat('***** DID NOT FIND A PULSE AT ', num2str(i), ' *******'));
            end
            
            j = j +1;
        end
    
    i = i +1;
end
latency'
clear dat;
end




