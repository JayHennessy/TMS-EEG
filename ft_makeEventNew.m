function [ trl ] = ft_makeEventNew( cfg, type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% read the header information and the events from the data
% hdr   = ft_read_header(cfg.dataset);
% event = ft_read_event(cfg.dataset);

% determine the number of samples before and after the trigger

%   change sampling rate here 
pretrig  = -round(cfg.trialdef.prestim  * cfg.data.fsample);  
posttrig =  round(cfg.trialdef.poststim *cfg.data.fsample);  

%search for pulse in the raw- continuous data
event_pos = [,];
i = 1;
j = 0;
count = 1;
offset = 6;

   
while j <= size(cfg.data.trial,2)-1
    i=1;
    while i <= size(cfg.data.trial{j+1},2)-511
        if (abs(cfg.data.trial{j+1}(5,i))>2500)
            
            event_pos(count,1) = (i-offset)+(2*j*cfg.data.fsample);
            event_pos(count,2) = type(j+1);
            count = count + 1;
            break;
%             if (max(abs(cfg.data.trial{j+1}(5,i+500:i+510)))<2000) && (max(abs(cfg.data.trial{j+1}(5,i+55:i+65)))<2000) && (min(abs(cfg.data.trial{j+1}(5,i+20:i+22)))>2000)
%                 
%                 event_pos(count,1) = (i-offset)+(2*j*cfg.data.fsample);
%                 event_pos(count,2) = type(j+1);
%                 count = count + 1;
%                 i = 1;
%                 break;
%             elseif (max(abs(cfg.data.trial{j+1}(5,i+500:i+510)))>2000) && (max(abs(cfg.data.trial{j+1}(5,i+55:i+65)))<2000) %&& (min(abs(cfg.data.trial{j+1}(5,i+20:i+22)))>2000)
%                 
%                 event_pos(count,1) = (i-offset)+(2*j*cfg.data.fsample);
%                 event_pos(count,2) = type(j+1);
%                 count = count + 1;
%                 i = 1;
%                 break;
%             elseif (max(abs(cfg.data.trial{j+1}(5,i+500:i+510)))<2000) && (max(abs(cfg.data.trial{j+1}(5,i+55:i+65)))>2000) %&& (min(abs(cfg.data.trial{j+1}(5,i+20:i+22)))>2000)
%                 
%                 event_pos(count,1) = (i-offset)+(2*j*cfg.data.fsample);
%                 event_pos(count,2) = type(j+1);
%                 count = count + 1;
%                 i = 1;
%                 break;
%             elseif (max(abs(cfg.data.trial{j+1}(5,i+500:i+510)))<2000) && (max(abs(cfg.data.trial{j+1}(5,i+55:i+65)))<2000) && (min(abs(cfg.data.trial{j+1}(5,i+20:i+22)))<2000)
%                 
%                 event_pos(count,1) = (i-offset)+(2*j*cfg.data.fsample);
%                 event_pos(count,2) = type(j+1);
%                 count = count + 1;
%                 i = 1;
%                 break;
%             else
%                % error(' Incorrect Event located');
%             end
        end
        i = i+1;
    end
    j= j+1;
end
   
ft_sampleinfo_var = zeros(2,size(event_pos,1));
size( event_pos)

for i = 1:size(event_pos,1)
%     if event_pos(i)<= cfg.data.fsample
%         ft_sampleinfo_var(1,i) = 1;
%     else
    ft_sampleinfo_var(1,i) = event_pos(i,1)-cfg.data.fsample;
   % end
    ft_sampleinfo_var(2,i) = event_pos(i,1)+cfg.data.fsample;  
end
ft_sampleinfo_var =ft_sampleinfo_var';

% define the trials
trl(:,1) =  ft_sampleinfo_var(:,1); % start of segment
trl(:,2) = ft_sampleinfo_var(:,2); % end of segment
trl(:,3) = pretrig;                    % how many samples prestimulus
trl(:,4) = event_pos(:,2); % this is the type of stimulus (i.e. single/double/etc)




end

