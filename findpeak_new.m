function [  value  ] = findpeak_new( data_type,dataset,type,channel,peak )
%UNTITLED Summary of this function goes here
%   This function finds the max peak value of the EMG response
%  [  value ] = findpeak(data_type, dataset, type,channel )
%
% data_type = 'EEG' or 'EMG'
% type 1 = single, 2 = lici, 3 = icf, 4 = sici.
% dataset should be an averaged over all cleaned trials
% peak = latency in ms at which to find the peak (should be 0 for all EMG)
%

if strcmp(data_type, 'EMG')
%if ~isempty(findstr(varname(dataset),'single'))
if type ==1
    
        value = max(abs(dataset(channel,5120:5300)));
   
    
end

%if ~isempty(findstr(varname(dataset),'lici'))
 if type ==2   
        value = max(abs(dataset(channel,5620:5800)));
   
 
end

%if ~isempty(findstr(varname(dataset),'icf'))
if type ==3   
        value = max(abs(dataset(channel,5110:5330)));
   
end

%if ~isempty(findstr(varname(dataset),'custom'))
if type==4    
        value = max(abs(dataset(channel,5130:5320)));
    
end

elseif strcmp(data_type, 'EEG')

%if ~isempty(findstr(varname(dataset),'single'))

    lim_min = 2500-25+peak*5;
    lim_max = 2500+25+peak*5;
    if peak ==60
    value = max(dataset(channel,lim_min:lim_max));
    elseif peak ==100
    value = min(dataset(channel,lim_min:lim_max));
    end



end

