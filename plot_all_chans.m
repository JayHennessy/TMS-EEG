for i=1:numel(data_filt.label)                   % Loop through all channels
    figure;
    plot(data_filt.time, data_filt.avg(i,:)); % Plot this channel versus time
    xlim([0.115 0.3]);     % Here we can specify the limits of what to plot on the x-axis
    ylim([-20 10]);       % Here we can specify the limits of what to plot on the y-axis
    title(['Channel ' data_filt.label{i}]);
    ylabel('Amplitude (uV)')
    xlabel('Time (s)');
end;