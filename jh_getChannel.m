function [ output ] = jh_getChannel( data, channel )
%
%
% [ output ] = jh_getChannel( data, channel )
%
% This function is used to get the index or the name of a channel in a EEG
% data structure that contains the 'label' field from fieldtrip or
% jh_process.
%
% Inputs:       data    = fieldtrip data structure
%               channel = either a channel index or a channel name
%
%
% Outputs:      output = Either a channel index or a channel name, which
%                        ever is the opposite of the input variable channel
%
%



% is user enters a channel index, return the string name
if isnumeric(channel)
    output = data.label(channel);
    
% if user enters a channel name, return the channel index
elseif ischar(channel)
    for ind = 1:length(data.label)
        if strcmp(data.label(ind),channel)
            output = ind;
        end
    
    end
    if ~exist('output')
        display(strcat('The channel  ', channel ,' does not exist'));
        output = 0; 
    end

else
    display('Channel must either be a string or a number');
    output = 0;
end

end

