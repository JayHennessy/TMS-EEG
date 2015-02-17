%% This is the EEGLAB

prompt = sprintf([' \n \n Please type the number of the file you would like to process: \n \n \n' ...
    ' 1  \\/Work\\/Fieldtrip Example data\\/jimher_toolkit_demo_dataset_.vhdr \n' ...
    ' 2  \\Work\\/EEG_Tests\\/Second Practice test 02-07-2014\\/Pilot2_pairedpulse_LeftM1_45.vhdr \n' ...
    ' 3  \\Work\\/EEG_Tests\\/Second Practice test 02-07-2014\\/Pilot2_singlepulse_LeftM1_45.vhdr \n' ...
    ' 4  \\Work\\/EEG_Tests\\/Giovanni test 03-06-2014\\/singlepulse_52.vhdr ' ...
    ' \n 5  \\/Work\\/EEG_Tests\\/Giovanni test 03-06-2014\\/lici100.vhdr ' ...
    ' \n 7  \\/Work\\/EEG_Tests\\/Second Practice test 02-07-2014\\/ramp_leftM!_100.vhdr ' ...
    ' \n 8  \\/Work\\/EEG_Tests\\/Second Practice test 02-07-2014\\/ramp_leftM!_140.vhdr ' ...
    ' \n 9  \\/Work\\/EEG_Tests\\/Third Practice test 17-10-2014\\/Jay_35_singlepulse.vhdr ' ...
    ' \n 10  \\/Work\\/EEG_Tests\\/Third Practice test 17-10-2014\\/Jay_48_singleandLICI_LeftM1.vhdr'  ...
    ' \n 11  \\/Work\\/EEG_Tests\\/Third Practice test 17-10-2014\\/Jay_47_LICI_leftM1.vhdr ' ...
    ' \n 12  \\/Work\\/EEG_Tests\\/Third Practice test 17-10-2014\\/Jay_single35_refnose.vhdr' ...
    ' \n 13  \\/Work\\/EEG_Tests\\/Third Practice test 17-10-2014\\/Jay_single_35_ref_and_ground_nose.vhdr' ...
    ' \n 14  This will let you enter the path of a new file \n \n ']);


result = input(prompt);

if ismember(result, [ 1 3 4 6 7 8 9 10 12 13])
    type = 1;
elseif ismember(result, [2 5 11])
    type = 2;
elseif ismember(result, [14])
    type = 0;
end

switch result
    case 1
        file_name = 'C:\Users\jay\Desktop\Work\Fieldtrip Example data\jimher_toolkit_demo_dataset_.vhdr';
    case 2
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_pairedpulse_LeftM1_45.vhdr';
    case 3
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_singlepulse_LeftM1_45.vhdr';
    case 4
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\singlepulse_52.vhdr';
    case 5
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\lici100.vhdr';
    case 6
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_80.vhdr';
    case 7
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_100.vhdr';
    case 8
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_140.vhdr';
    case 9
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_35_singlepulse.vhdr';
    case 10
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_48_singleandLICI_LeftM1.vhdr';
    case 11
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_47_LICI_leftM1.vhdr';
    case 12
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_single35_refnose.vhdr';
    case 13
        file_name = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_single_35_ref_and_ground_nose.vhdr';
    case 14
        prompt = sprintf([' \n Please enter the path of the ".vhdr" file you would like to process. \n \n ']);
        file_name = input(prompt);
        prompt = sprintf([' \n \n Please type the number of the file type you would like to process: \n \n \n' ...
            ' 1  Single Pulse \n' ...
            ' 2  Double Pulse \n' ...
            ' 3  ICF Pulse' ...
            ' \n 4  mix  \n \n ']);
        type = input(prompt);
        
        if ismember(type, [ 1 ])
            type = 1;
        elseif ismember(type, [2 ])
            type = 2;
        elseif ismember(type, [3])
            type = 3;
        elseif ismember(type, [4])
            type = 4;
        end
        
end

prefix_vec = strfind(file_name, '\');
if isempty(prefix_vec)
    prefix_vec = strfind(file_name, '/');
end   
prefix = file_name(1:prefix_vec(end)-1);
suffix = file_name(prefix_vec(end)+1:end);


hdr_name = strcat(file_name(1:end-4),'vmrk');

[mrk location] = readMRK(hdr_name);

addpath('C:\Users\jay\Desktop\Work\TMS-EEG');
addpath('C:\Program Files\MATLAB\R2011a\toolbox\eeglab13_4_4b');

eeglab

EEG = pop_loadbv(prefix,suffix);
EEG.setname='raw_data';
EEG = eeg_checkset( EEG );

%choose channel file

if EEG.nbchan == 30
    EEG=pop_chanedit(EEG, 'load',{'C:\Users\jay\Desktop\Work\channels\jay_good_channels_30.ced' 'filetype' 'autodetect'});
elseif EEG.nbchan == 32
    EEG=pop_chanedit(EEG, 'load',{'C:\Users\jay\Desktop\Work\channels\jay_good_channels.ced' 'filetype' 'autodetect'},'delete',32);
elseif EEG.nbchan >= 60
    %maybe figure out how to get the channel here
else
    error('you messed up the channels');
end

EEG = eeg_checkset( EEG );

%% make events if they arent already in the data

    j = makeEventNew(EEG,EEG.srate,mrk, location);
    EEG = pop_importevent( EEG, 'append','no','event', 'C:\Users\jay\Desktop\Work\TMS-EEG\event.txt','fields',{'latency' 'type'},'skipline',1,'timeunit',1);
    EEG = eeg_checkset( EEG );


%% Epoch the data



EEG = pop_epoch( EEG, {  'S 1' 'S 2' 'S 3' 'S1' 'S2' 'S3' 'S4' 'S 4' }, [-1  1], 'newname', 'single epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-900     -50]);
EEG = eeg_checkset( EEG );

chanNumStart = EEG.nbchan;
numEpochs = EEG.trials;
%%    First make sure that you use EEGLAB to import the events and epoch the 
%     data. When that EEG file is in the workspace this should work
% % %
%real shit
addpath('C:\Users\jay\Desktop\Work\fieldtrip-20140804');
addpath('C:\Users\jay\Desktop\Work\fieldtrip-20140804\fileio');
    %% first we load the cfg with the data and define the trial
%
%  ** make sure to change the dataset when you use different data sets
cfg = [];

cfg.dataset = file_name;
title = cfg.dataset;
%%
cfg.hdr = ft_read_header(cfg.dataset);


%%

cfg.continuous              = 'no';
cfg.trialdef.prestim        = 1;         % prior to event onset
cfg.trialdef.poststim       = 1;        % after event onset
cfg.trialdef.eventtype      = 'stimulus'; % see above
cfg.trialdef.eventvalue     = {'S1' 'S2' 'S3' 'S4' 'S 1' 'S 2' 'S 3' 'S 4'} ;

%     Change this when not doing field trip example
cfg.data = eeglab2fieldtrip(EEG, 'preprocessing', 'none');
data = cfg.data;

    

if strfind(title, 'Third Practice test 17-10-2014')==37
    triggers = {'S  1', 'S  2'};
    cfg.trialdef.eventtype      = 'Stimulus'; % see above
    cfg.trialdef.eventvalue     = triggers ;
    data_set = 2;
else
    cfg.trialdef.prestim        = 1;         % prior to event onset
    cfg.trialdef.poststim       = 1;        % after event onset
    cfg.trl = ft_makeEventNew(cfg,mrk);
    data_set = 4;
   
end

cfg = ft_definetrial(cfg);
trl = cfg.trl;


%% Display the segmented data to find bad channels
 %
 cfg.blocksize = 2;
cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data);

chans = 0;

while chans == 0
prompt = '\n \n Please enter a cell array containing the names of the bad channels \n \n ';
badChannels = input(prompt);

%% REMOVE BAD CHANNELS
% 
%  ** not that these channels have to be changed. Probably easiest to see
%  in eeglab

if data_set == 1
    selchan = ft_channelselection({'all' '-T7' '-TP10' '-FC1' '-EMG1' '-EMG2'}, cfg.data.label);
    data = ft_selectdata(data, 'channel', selchan);
elseif data_set ==2
    selchan = ft_channelselection({'all' '-F3' '-TP9' }, cfg.data.label);
    data = ft_selectdata(data, 'channel', selchan);
elseif data_set == 0
    selchan = ft_channelselection({'all' '-FC1' '-Fz' }, cfg.data.label);
    data = ft_selectdata(data, 'channel', selchan); 
else
    badChanCell = cell(1,size(badChannels,2)+1);
    badChanCell{1} = 'all';
    for i = 1:size(badChannels,2)
        x = i+1;
        badChanCell{x} = strcat('-',badChannels{i});
    end
    
    selchan = ft_channelselection(badChanCell, cfg.data.label);
    data = ft_selectdata(data, 'channel', selchan);  
end
        cfg.blocksize = 2;
        cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
        ft_databrowser(cfg, data);
        
prompt = '\n \n Are you pleased with the result?  [1 = y / 0 = n] \n \n ';
chans = input(prompt);

end

%% Divide the data if it is of type 4
%data1

trl_2 = trl;



trials_single = find(trl(:,4)==1);
trials_lici = find(trl(:,4)==2);
trials_icf = find(trl(:,4)==3);
trials_custom = find(trl(:,4)==4);


%% set rejection markers
%data2
%type is 1 if single pulse or 2 if paired pulse
result = 'n';

if ~isempty(trials_single)
    while strcmp(result, 'n')
prompt = ['\n \n At what cut-off time would you like your TMS ringing cut for SINGLE pulse? \n '...
            ' (note: time is in seconds and 0 means compute automatically) \n \n'];

poststim_single = input(prompt);

 data_single = data;
    data_single.trial = [];
    data_single.time = [];

for i = 1:size(trials_single,1)
    
    data_single.trial{i} = data.trial{trials_single(i)};
    data_single.time{i} = data.time{trials_single(i)};
end
trl_single = trl(trials_single,:);
    cfg = [];
    
    cfg.trl = trl_single;
    cfg.continuous = 'no';
    cfg.method = 'marker';
    
    if data_set == 2
        cfg.prestim = -0.007;
    else
        cfg.prestim = 0;
    end
  
    if poststim_single == 0
        [cutoff_single cutinterval time] = ft_getCutoff(data_single, cfg, type);% 1 if single pulse, 2 if double pulse
        cfg.poststim = cutoff_single;
    else
        
        cfg.poststim = poststim_single;
        cutoff_single = poststim_single;
    end
    
    if data_set == 2
        cfg.poststim = cutoff_single+0.007;
        cutoff_single = cfg.poststim;
    end
    
    prestim_single = cfg.prestim;
    cfg.Fs = 5000;
    triggers = {'S 1', 'S 2'};
    cfg.trialdef.eventtype      = 'S1'; % see above
    cfg.trialdef.eventvalue     = {'S1'} ;
    %cfg.trialdef.eventtype  = 'p-pulse';
    %cfg.trialdef.eventvalue = 1000;
    if type == 4
        cfg.trials = trials_single;
    end
    cfg.trialfun = 'ft_markpulse';
    
    [cfg_artifact_single, artifact_single] = ft_artifact_tms(cfg, data_single);
    
    % reject artifact
    cfg_artifact_single.artfctdef.reject = 'partial';
    cfg_artifact_single.artfctdef.minaccepttim = 0.01;
    data_single = ft_rejectartifact(cfg_artifact_single, data_single);
    cfg.blocksize = 2;
    cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
    ft_databrowser(cfg, data_single);
    
    prompt = '\n \n Is the cut-off at an acceptable latency?     [y/n] \n \n ';
    result = input(prompt);
    end
end

result = 'n';
if ~isempty(trials_lici)
     while strcmp(result, 'n')
prompt = ['\n \n At what cut-off time would you like your TMS ringing cut for LICI pulse? \n '...
            ' (note: time is in seconds and 0 means compute automatically) \n \n'];

poststim_lici = input(prompt);
    
 data_lici = data;
    data_lici.trial = [];
    data_lici.time = [];
for i = 1:size(trials_lici,1)
    
    data_lici.trial{i} = data.trial{trials_lici(i)};
    data_lici.time{i} = data.time{trials_lici(i)};
end
trl_lici = trl(trials_lici,:);
    %remove the second pulse
    cfg = [];
    cfg.trl = trl_lici;
    
    cfg.continuous = 'no';
    cfg.method = 'marker';
    
    if data_set == 2
         cfg.prestim = -0.105;    
    else
        cfg.prestim = -0.098;
    end
  
    if poststim_lici == 0
        [cutoff_lici cutinterval time] = ft_getCutoff(data_lici, cfg, type);% 1 if single pulse, 2 if double pulse
        cfg.poststim = cutoff_lici;
    else
        
        cfg.poststim = poststim_lici+0.1;
        cutoff_lici = poststim_lici+0.1;
    end
    
    if data_set == 2
        cfg.poststim = cutoff_lici+0.007;
        cutoff_lici = cfg.poststim;
    end
    
     
    
    prestim_lici = cfg.prestim;
    cfg.Fs = 5000;
    cfg.trialdef.eventtype  = 'S2';
    cfg.trialdef.eventvalue = 'S2';
    if type == 4
        cfg.trials = trials_lici;
    end
    cfg.trialfun = 'ft_markpulse';
    [cfg_artifact_lici, artifact_lici] = ft_artifact_tms(cfg, data_lici);
    
    % reject artifact
    cfg_artifact_lici.artfctdef.reject = 'partial';
    cfg_artifact_lici.artfctdef.minaccepttim = 0.01;
    data_lici = ft_rejectartifact(cfg_artifact_lici, data_lici);
    
    % remove first pulse
    cfg = [];
    cfg.trl = trl;
    cfg.continuous = 'no';
    cfg.method = 'marker';
    cfg.prestim = 0.002;
    
    cfg.poststim = 0.012;
    cfg.Fs = 5000;
    cfg.trialdef.eventtype  = 'S2';
    cfg.trialdef.eventvalue = 'S2';
    if type == 4
        cfg.trials = trials_lici;
    end
    cfg.type = 2;
    cfg.trialfun = 'ft_markpulse';
    [cfg_artifact_lici, artifact_lici] = ft_artifact_tms(cfg, data_lici);
    
    % reject artifact
    cfg_artifact_lici.artfctdef.reject = 'partial';
    cfg_artifact_lici.artfctdef.minaccepttim = 0.01;
    data_lici = ft_rejectartifact(cfg_artifact_lici, data_lici);
    cfg.blocksize = 2;
    cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
    ft_databrowser(cfg, data_lici);
    
    prompt = '\n \n Is the cut-off at an acceptable latency?     [y/n] \n \n ';
    result = input(prompt);
     end
end


result = 'n';
if ~isempty(trials_icf)
     while strcmp(result, 'n')
prompt = ['\n \n At what cut-off time would you like your TMS ringing cut for ICF pulse? \n '...
            ' (note: time is in seconds and 0 means compute automatically) \n \n'];

poststim_icf = input(prompt);
 data_icf= data;
    data_icf.trial = [];
    data_icf.time = [];
for i = 1:size(trials_icf,1)
    
    data_icf.trial{i} = data.trial{trials_icf(i)};
    data_icf.time{i} = data.time{trials_icf(i)};
end
trl_icf = trl(trials_icf,:);
    cfg = [];
    
    cfg.trl = trl_icf;
    cfg.continuous = 'no';
    cfg.method = 'marker';

    cfg.prestim = 0;

    if poststim_icf == 0
        [cutoff_icf cutinterval time] = ft_getCutoff(data_icf, cfg, type);% 1 if single pulse, 2 if double pulse
        cfg.poststim = cutoff_icf;
    else
        
        cfg.poststim = poststim_icf;
        cutoff_icf = poststim_icf;
    end
    
    prestim_icf = cfg.prestim;
    cfg.Fs = 5000;
    triggers = {'S 1', 'S 2'};
    cfg.trialdef.eventtype      = 'S1'; % see above
    cfg.trialdef.eventvalue     = {'S1'} ;
    %cfg.trialdef.eventtype  = 'p-pulse';
    %cfg.trialdef.eventvalue = 1000;
    if type == 4
        cfg.trials = trials_icf;
    end
    cfg.trialfun = 'ft_markpulse';
    
    [cfg_artifact_icf, artifact_icf] = ft_artifact_tms(cfg, data_icf);
    
    % reject artifact
    cfg_artifact_icf.artfctdef.reject = 'partial';
    cfg_artifact_icf.artfctdef.minaccepttim = 0.01;
    data_icf = ft_rejectartifact(cfg_artifact_icf, data_icf);
    cfg.blocksize = 2;
    cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
    ft_databrowser(cfg, data_icf);
    
    prompt = '\n \n Is the cut-off at an acceptable latency?     [y/n] \n \n ';
    result = input(prompt);
    
     end
end

result = 'n';
if ~isempty(trials_custom)
     while strcmp(result, 'n')
prompt = ['\n \n At what cut-off time would you like your TMS ringing cut for CUSTOM pulse? \n '...
            ' (note: time is in seconds and 0 means compute automatically) \n \n'];

poststim_custom = input(prompt);

    data_custom = data;
    data_custom.trial = [];
    data_custom.time = [];
for i = 1:size(trials_custom,1)
   
    data_custom.trial{i} = data.trial{trials_custom(i)};
    data_custom.time{i} = data.time{trials_custom(i)};
end

trl_custom = trl(trials_custom,:);
    cfg = [];
    
    cfg.trl = trl_custom;
    cfg.continuous = 'no';
    cfg.method = 'marker';

    cfg.prestim = 0;

    if poststim_custom == 0
        [cutoff_custom cutinterval time] = ft_getCutoff(data_custom, cfg, type);% 1 if single pulse, 2 if double pulse
        cfg.poststim = cutoff_custom;
    else
        
        cfg.poststim = poststim_custom;
        cutoff_custom = poststim_custom;
    end
    
    prestim_custom = cfg.prestim;
    cfg.Fs = 5000;
    triggers = {'S 1', 'S 2'};
    cfg.trialdef.eventtype      = 'S1'; % see above
    cfg.trialdef.eventvalue     = {'S1'} ;
    %cfg.trialdef.eventtype  = 'p-pulse';
    %cfg.trialdef.eventvalue = 1000;
    if type == 4
        cfg.trials = trials_custom;
    end
    cfg.trialfun = 'ft_markpulse';
    
    [cfg_artifact_custom, artifact_custom] = ft_artifact_tms(cfg, data_custom);
    
    % reject artifact
    cfg_artifact_custom.artfctdef.reject = 'partial';
    cfg_artifact_custom.artfctdef.minaccepttim = 0.01;
    data_custom = ft_rejectartifact(cfg_artifact_custom, data_custom);
    
    cfg.blocksize = 2;
    cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
    ft_databrowser(cfg, data_custom);
    
    prompt = '\n \n Is the cut-off at an acceptable latency?     [y/n] \n \n ';
    result = input(prompt);
     end
end
    
 
 % Memory 74% (1,777MB)
 
%% Display the segmented data including the artifacts that are gone
 %

 
 % data structure is all messed up here
 
 
stop = exist('data_single')+exist('data_lici')+exist('data_icf')+exist('data_custom');


%******************************* for loop here **************************
for x = 1:stop

    
    if exist('data_single') && x==1
        do_ica = 1;
        trials = trl_single;
        cutoff = cutoff_single;
        prestim = prestim_single;
        data = data_single;
        cfg = [];
        cfg.artfctdef = cfg_artifact_single.artfctdef; % Store previously obtained artifact definition
        
    end
    if exist('data_lici') && x==2
        do_ica = 2;
        trials = trl_lici;
        cutoff = cutoff_lici;
        prestim = prestim_lici;
        data = data_lici;
        cfg = [];
        cfg.artfctdef = cfg_artifact_lici.artfctdef; % Store previously obtained artifact definition
        
    end
    if exist('data_icf') && x ==3
        do_ica =3;
        trials = trl_icf;
        cutoff = cutoff_icf;
        prestim = prestim_icf;
        data = data_icf;
        cfg = [];
        cfg.artfctdef = cfg_artifact_icf.artfctdef; % Store previously obtained artifact definition
     
    end
    if exist('data_custom') && x ==4
        do_ica = 4;
        trials = trl_custom;
        cutoff = cutoff_custom;
        prestim = prestim_custom;
        data = data_custom;
        cfg = [];
        cfg.artfctdef = cfg_artifact_custom.artfctdef; % Store previously obtained artifact definition
        
    end
    
   
    %% redefine the trial into original epoch sizes
    

if do_ica ==2
    
    data_temp = data;
  	data.trial = cell(1,size(data_temp.trial,2)/3);
    data.time = cell(1,size(data_temp.time,2)/3);
    data.sampleinfo = zeros(size(data_temp.time,2)/3,2);
    trl2 = data_temp.cfg.trl;
   
    z=0;
    for i = 1:size(data_temp.trial,2)/3
        
        % odd
        y = 3*i - 2;
        data.trial{i} = data_temp.trial{y};
        
        w = 3*i - 1;
        data.trial{i}(:,size(data_temp.trial{w-1},2)+1:size(data_temp.trial{w-1},2)+0.014*data.fsample) = nan;
        data.trial{i}(:,size(data_temp.trial{w-1},2)+0.014*data.fsample+1:size(data_temp.trial{w-1},2)+0.014*data.fsample+size(data_temp.trial{w},2)) = data_temp.trial{w};

        %even
        x = 3*i;
        data.trial{i}(:,size(data_temp.trial{x-1},2)+size(data_temp.trial{x-2},2)+0.014*data.fsample+1:size(data_temp.trial{x-1},2)+size(data_temp.trial{x-2},2)+0.014*data.fsample+(cutoff-0.1)*data.fsample) = nan;
        data.trial{i}(:,size(data_temp.trial{x-1},2)+size(data_temp.trial{x-2},2)+0.014*data.fsample+(cutoff-0.1)*data.fsample+1:size(data_temp.trial{x-1},2)+size(data_temp.trial{x-2},2)+0.014*data.fsample+(cutoff-0.1)*data.fsample+size(data_temp.trial{x},2)) = data_temp.trial{x};
      
        
        
        data.time{i} = -1:0.0002:0.9998;
        data.sampleinfo(i,1) = z*size(data.trial{i},2)+1 ;
        data.sampleinfo(i,2) = (z+1)*size(data.trial{i},2);
        
        z=z+1;
    end
    
    trl = trials;
else
    
    % this is for all the types except LICI
    
    data_temp = data;
  	data.trial = cell(1,size(data_temp.trial,2)/2);
    data.time = cell(1,size(data_temp.time,2)/2);
    data.sampleinfo = zeros(size(data_temp.time,2)/2,2);
    trl2 = data_temp.cfg.trl;
   
    z=0;
    for i = 1:size(data_temp.trial,2)/2
        
        % odd
        y = 2*i - 1;
        data.trial{i} = data_temp.trial{y};
       % data.time{i} = data_temp.time{y};
       
        %even
        x = 2*i;
        data.trial{i}(:,size(data_temp.trial{x-1},2)+1:size(data_temp.trial{x-1},2)+cutoff*data.fsample) = nan;
        data.trial{i}(:,size(data_temp.trial{x-1},2)+cutoff*data.fsample+1:size(data_temp.trial{x-1},2)+cutoff*data.fsample+size(data_temp.trial{x},2)) = data_temp.trial{x};
       % data.time{i}(:,size(data_temp.time{x-1},2)+1:size(data_temp.time{x-1},2)+cutoff*data.fsample) = nan;
        %data.time{i}(:,size(data_temp.time{x-1},2)+cutoff*data.fsample+1:size(data_temp.time{x-1},2)+cutoff*data.fsample+size(data_temp.time{x},2)) = data_temp.time{x};
        
        data.time{i} = -1:0.0002:0.9998;
        data.sampleinfo(i,1) = z*size(data.trial{i},2)+1 ;
        data.sampleinfo(i,2) = (z+1)*size(data.trial{i},2);
        
        z=z+1;
    end
    
    trl = trials;
end
%%
% jump
cfg                    = [];
cfg.headerfile = file_name;
 
% channel selection, cutoff and padding
cfg.artfctdef.zvalue.channel    = 'EEG';
cfg.artfctdef.zvalue.cutoff     = 20;
cfg.artfctdef.zvalue.trlpadding = 0;
cfg.artfctdef.zvalue.artpadding = 0;
cfg.artfctdef.zvalue.fltpadding = 0;
 
% algorithmic parameters
cfg.artfctdef.zvalue.cumulative    = 'yes';
cfg.artfctdef.zvalue.medianfilter  = 'yes';
cfg.artfctdef.zvalue.medianfiltord = 9;
cfg.artfctdef.zvalue.absdiff       = 'yes';
 
% make the process interactive
cfg.artfctdef.zvalue.interactive = 'yes';
 
[cfg, artifact_jump] = ft_artifact_zvalue(cfg,data);

% data = ft_rejectartifact(cfg, data);

%% Browse data for bad epochs

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.9 -0.01];
ft_databrowser(cfg, data);
 
prompt = ' \n \n Please enter an array containing the indices of the epochs that you would like to discard \n \n';
rejectArray = input(prompt);
%% Remove bad epochs

%rejectArray = cat(2, rejectArray, artifact_jump);
%rejectArray = unique(rejectArray);

cfg = [];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.xxx.artifact = ft_xxxReject(data,rejectArray , data.fsample);
numEpochsRmv = length(rejectArray);
data = ft_rejectartifact(cfg, data);



trl = data.cfg.trl;

%% redefine trial to what it was before we removed the bad trials

if do_ica == 2
    
    trl3 = zeros(size(data.trial,2)*2,3);
    index = 1;
    for i = 1: size(data.trial,2)+length(rejectArray)
        
        if ~any(rejectArray==i)
            % odd
            y = 3*index - 2;
            trl3(y,1) = (i-1)*size(data.trial{index},2) + 1;
            trl3(y,2) = (i-1)*size(data.trial{index},2) + find(isnan(data.trial{index}(1,:)),1) - 1;
            trl3(y,3) = find(isnan(data.trial{index}(1,:)),1) - 1;
            
            w = 3*index - 1;
            last =  find(isnan(data.trial{index}(1,:))==1);
            r = find(diff(last)~=1);
           
            trl3(w,1) = (i-1)*size(data.trial{index},2) + last(r)+ 1;
            trl3(w,2) = (i-1)*size(data.trial{index},2) + last(r+1) - 1;
            trl3(w,3) = last(r+1)-last(1);
            
            %even
            x = 3*index;
            trl3(x,1) = (i-1)*size(data.trial{index},2) + last(end) + 1;
            trl3(x,2) = (i)*size(data.trial{index},2);
            trl3(x,3) = last(end);
            
            index = index + 1;
            
        end
    end
    
else    % redefine everything but lici
    trl3 = zeros(size(data.trial,2)*2,3);
    index = 1;
    for i = 1: size(data.trial,2)+length(rejectArray)
        
        if ~any(rejectArray==i)
            % odd
            y = 2*index - 1;
            trl3(y,1) = (i-1)*size(data.trial{index},2) + 1;
            trl3(y,2) = (i-1)*size(data.trial{index},2) + find(isnan(data.trial{index}(1,:)),1) - 1;
            trl3(y,3) = find(isnan(data.trial{index}(1,:)),1) - 1;
            
            %even
            x = 2*index;
            last =  find(isnan(data.trial{index}(1,:))==1);
            trl3(x,1) = (i-1)*size(data.trial{index},2) + last(end) + 1;
            trl3(x,2) = (i)*size(data.trial{index},2);
            trl3(x,3) = -cutoff*data.fsample;
            
            index = index + 1;
            
        end
    end
end

%%
    cfg = [];
    cfg.trl = trl3;
    data = ft_redefinetrial(cfg, data);




%% Perform ICA on segmented data
%
        cfg = [];
        cfg.demean = 'yes';
        cfg.method = 'fastica';        % FieldTrip supports multiple ways to perform ICA, 'fastica' is one of them.
        cfg.fastica.approach = 'symm'; % All components will be estimated simultaneously.
        cfg.fastica.g = 'gauss';
        
        comp_tms = ft_componentanalysis(cfg, data);
        
        numComp = size(comp_tms.label,1);
        
        %% Show averages of the time analysis and topographic images
        
        cfg = [];
        cfg.vartrllength  = 2; % This is necessary as our trials are in fact segments of our original trials. This option tells the function to reconstruct the original trials based on the sample-information stored in the data
        comp_tms_avg = ft_timelockanalysis(cfg, comp_tms);
        
        figure;
        cfg = [];
        cfg.viewmode = 'butterfly';
        ft_databrowser(cfg, comp_tms_avg);
        
        figure;
        cfg           = [];
        cfg.component = 1:size(comp_tms.label,1);
        cfg.comment   = 'no';
        cfg.layout    = 'easycap_J61'; % If you use a function that requires plotting of topographical information you need to supply the function with the location of your channels
        ft_topoplotIC(cfg, comp_tms);
        
        figure;
        cfg = [];
       
        cfg.plotlabels = 'yes';
        cfg.viewmode = 'vertical';
        ft_databrowser(cfg, comp_tms);
        
        prompt = '\n \n Would you like to see the frequency analysis? \n \n';
        result = input(prompt);
        
        %% frequency analysis
        
        if strcmp(result, 'y')
            cfg = [];
            cfg.polyremoval     = 1; % Removes mean and linear trend
            cfg.output          = 'pow'; % Output the powerspectrum
            cfg.method          = 'mtmconvol';
            cfg.taper           = 'hanning';
            cfg.foi             = 1:30; % Our frequencies of interest. Now: 1 to 50, in steps of 1.
            cfg.t_ftimwin       = 0.3.*ones(1,numel(cfg.foi));
            cfg.toi             = -0.5:0.05:1.5;
            
            freq         = ft_freqanalysis(cfg, comp_tms);
            
            
            tmpLabels = freq.label;
            for i = 1:size(comp_tms.label,1)
                freq.label{i} = data.label{i};
            end
            
            cfg = [];
            cfg.xlim = [-1 1.0]; % Specify the time range to plot
            cfg.zlim = [-500 500];
            cfg.layout = 'ordered';
            cfg.showlabels = 'yes';
            
            figure;
            ft_multiplotTFR(cfg, freq);
            
        end
        %% Use unmixing matrix to get original data back to remove components
        
        cfg          = [];
        cfg.demean   = 'no'; % This has to be explicitly stated as the default is to demean.
        cfg.unmixing = comp_tms.unmixing; % Supply the matrix necessay to 'unmix' the channel-series data into components
        cfg.topolabel = comp_tms.topolabel; % Supply the original channel label information
        
        comp_tms         = ft_componentanalysis(cfg, data);  % MAKE SURE THIS IS SUPPOSED TO BE DATA_VISUAL AND NOT COMP_TMS
        
        %% Reject components
        
        prompt = '\n \n Please enter a vector containing the indices of the components to reject  \n \n';
        removeArray = input(prompt);
        
        cfg            = [];
        
        cfg.component  = removeArray;
        cfg.demean     = 'no';
        numCompRmv     = size(removeArray,2);
        
        data_tms_clean_segmented = ft_rejectcomponent(cfg, comp_tms);
        
        
        %% Restructure the data
        
        % Apply original structure to segmented data, gaps will be filled with nans
        cfg     = [];
        cfg.trl = trl;
    	
        data_tms_clean = ft_redefinetrial(cfg, data_tms_clean_segmented); % Restructure cleaned data
        
        
        %*** check this out. it might go here or in the next one
        
        
        %data_tms_clean = remove_nan_trial(data_tms_clean);
        

% %% Interpolate the data
% 
% if do_ica==1 || do_ica ==4 || do_ica ==3
% % Replacing muscle artifact with nans
%     muscle_window = [prestim cutoff]; % The window we would like to replace with nans
%     muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
%     for i=1:size(data_tms_clean.trial,2) % Loop through all trials
%       data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
%     end;
% end
% 
% 
%       %% Interpolate the data for the second pulse
% if do_ica == 2
% % Replacing muscle artifact with nans
%     muscle_window = [-0.002 0.012]; % The window we would like to replace with nans
%     muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
%     for i=1:size(data_tms_clean.trial,2) % Loop through all trials
%       data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
%     end;
% % Replacing muscle artifact with nans
%     muscle_window = [prestim cutoff]; % The window we would like to replace with nans
%     muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
%     for i=1:size(data_tms_clean.trial,2) % Loop through all trials
%       data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
%     end;
% end 
%%

    % Interpolate nans using cubic interpolation
    cfg = [];
    cfg.method = 'cubic'; % Here you can specify any method that is supported by interp1: 'nearest','linear','spline','pchip','cubic','v5cubic'
    cfg.prewindow = 0.010; % Window prior to segment to use data points for interpolation
    cfg.postwindow = 0.010; % Window after segment to use data points for interpolation
    data_tms_clean = ft_interpolatenan(cfg, data_tms_clean); % Clean data

  
    
    



    %% Filter the data


cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.9 -0.01];
cfg.preproc.bpfilter = 'yes';
cfg.preproc.bpfreq = [0.3 120];
cfg.preproc.bsfilter = 'yes';
cfg.preproc.bsfreq = [59 61];
cfg.preproc.type = 'firws';
data_filt = ft_preprocessing(cfg, data_tms_clean);


 %% find bad Epochs
 
 cfg = [];
 cfg.preproc.demean = 'yes';
 cfg.preproc.detrend = 'yes';
 cfg.preproc.baselinewindow = [-1 -0.01];
 
 ft_databrowser(cfg, data_filt);
 
 


%% test for artifact rejection 

prompt = '\n \n Please enter a vector containing the indices of the trials to reject \n \n';
rejectArray = input(prompt);


cfg = [];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.xxx.artifact = ft_xxxReject(data_filt,rejectArray, data.fsample);

numEpochsRmv2 = size(rejectArray,2);

data_filt = ft_rejectartifact(cfg, data_filt);

trl = data.cfg.trl;

data_tms_clean = data_filt;

%% browse data

 cfg.preproc.demean = 'no';
 %cfg.layout = 'easycapM23.lay';
 ft_databrowser(cfg, data_filt);
 


%% Convert back to EEGLAB

fieldtrip2eeglab
chanNumEnd = size(EEG.data,1);

logData( title, type, chanNumStart, chanNumEnd, numEpochs, numEpochsRmv, cutoff, numComp, numCompRmv, numEpochsRmv2)

display(' \n \n Your data is now processed and in the variable ''EEG'' \n \n ');

end
