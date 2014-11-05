%
% Choose the channel you want to show below
%

channel = '5';
 
figure;
i = find(strcmp(channel, data_tms_avg.label));
 plot(data_tms_avg.time, data_tms_avg.avg(i,:));  % Plot data
xlim([-0.1 0.6]);    % Here we can specify the limits of what to plot on the x-axis
ylim([-23 15]);      % Here we can specify the limits of what to plot on the y-axis
title(['Channel ' data_tms_avg.label{i}]);
ylabel('Amplitude (uV)')
xlabel('Time (s)');