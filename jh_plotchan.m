function [ out ] = jh_plotchan( data, chan )
%
%
% [ out ] = jh_plotchan( data, chan )
%
% This function plots the averaged EEG channel data
%
%   Inputs:     data    =   fieldtrip data structure with averaged data.
%               chan    =   Channel you want to plot, can either be a
%                           number or a string name.
%
%   Output:     out     =   1 if successful 0 if not
%
%

% check to see if the data is averaged.
if isfield(data, 'avg')
    out = 1;
else
    out = 0;
    display('**** DATA IS NOT AVERAGED***');
end

% get the channel number
if ischar(chan)
    chan = jh_getChannel(data, chan);
end

if chan == 0
    out = 0;
else
    
    % plot the channel
    figure;
    plot(-data.prestim:1/5000:data.poststim-1/5000, data.avg(chan,:));
    title(['Channel ' data.label{chan}]);
    ylabel('Amplitude (uV)')
    xlabel('Time (s)');
    set(gca,'Xtick', -.5:0.1:1)
    grid on
    out = 1;
end
end

