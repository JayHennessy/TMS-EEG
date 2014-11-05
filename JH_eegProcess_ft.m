%% This is the EEGLAB

% choose a file

% 'C:\Users\jay\Desktop\Work\Fieldtrip Example data\jimher_toolkit_demo_dataset_.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_pairedpulse_LeftM1_45.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_singlepulse_LeftM1_45.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\singlepulse_52.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\lici100.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_80.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_100.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_140.vhdr';
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_35_singlepulse.vhdr'
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_48_singleandLICI_LeftM1.vhdr'
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_47_LICI_leftM1.vhdr'
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_single35_refnose.vhdr'
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_single_35_ref_and_ground_nose.vhdr'
% 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014','Jay_48_singleandLICI_LeftM1.vhdr'

addpath('C:\Users\jay\Desktop\Work\TMS-EEG\');
addpath('C:\Program Files\MATLAB\R2011a\toolbox\eeglab13_3_2b');
eeglab

EEG = pop_loadbv('C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014','lici100.vhdr');
EEG.setname='single100';
EEG = eeg_checkset( EEG );

%choose channel file

if EEG.nbchan == 30
    EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\jay\\Desktop\\Work\\Channels\\jay_good_channels_30.ced' 'filetype' 'autodetect'});
elseif EEG.nbchan == 32
    EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\jay\\Desktop\\Work\\Channels\\jay_good_channels.ced' 'filetype' 'autodetect'},'delete',32);
else
    error('you messed up the channels');
end

EEG = eeg_checkset( EEG );

%% make events if they arent already in the data
makeEvent(EEG,5000);
EEG = pop_importevent( EEG, 'append','no','event','C:\\Users\\jay\\Desktop\\Work\\TMS-EEG\\event.txt','fields',{'latency' 'type'},'skipline',1,'timeunit',1);
EEG = eeg_checkset( EEG );

%% Epoch the data
eventtype = EEG.event(2).type;
eventtype2 = EEG.event(3).type;
EEG = pop_epoch( EEG, {  eventtype eventtype2  }, [-1  1], 'newname', 'single epochs', 'epochinfo', 'yes');
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
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_pairedpulse_LeftM1_45.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\Pilot2_singlepulse_LeftM1_45.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\singlepulse_52.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\Fieldtrip Example data\jimher_toolkit_demo_dataset_.vhdr';
cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Giovanni test 03-06-2014\lici100.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_80.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_100.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Second Practice test 02-07-2014\ramp_leftM!_140.vhdr';
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_35_singlepulse.vhdr'
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_48_singleandLICI_LeftM1.vhdr'
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_single35_refnose.vhdr'
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_single_35_ref_and_ground_nose.vhdr'
%cfg.dataset = 'C:\Users\jay\Desktop\Work\EEG_Tests\Third Practice test 17-10-2014\Jay_47_LICI_leftM1.vhdr'
title = cfg.dataset;
%%
cfg.hdr = ft_read_header(cfg.dataset);
%%

cfg.continuous              = 'no';
cfg.trialdef.prestim        = 1;         % prior to event onset
cfg.trialdef.poststim       = 1;        % after event onset
cfg.trialdef.eventtype      = 'p-pulse'; % see above
cfg.trialdef.eventvalue     = 1000 ;

%     Change this when not doing field trip example
cfg.data = eeglab2fieldtrip(EEG, 'preprocessing', 'none');
data = cfg.data;

if strfind(title, 'Third Practice test 17-10-2014')==37
    triggers = {'S  1', 'S  2'};
    cfg.trialdef.eventtype      = 'Stimulus'; % see above
    cfg.trialdef.eventvalue     = triggers ;
    data_set = 2;
elseif strfind(title, 'Second Practice test 02-07-2014')== 37
    cfg.trialdef.prestim        = 1;         % prior to event onset
    cfg.trialdef.poststim       = 1;        % after event onset
    cfg.trl = ft_makeEvent(cfg);
    data_set = 1;
elseif strfind(title, 'Giovanni test 03-06-2014')== 37
    cfg.trialdef.prestim        = 1;         % prior to event onset
    cfg.trialdef.poststim       = 1;        % after event onset
    cfg.trl = ft_makeEvent(cfg);
    data_set = 0;
end

cfg = ft_definetrial(cfg);
trl = cfg.trl;

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
end


%% Browse data for bad epochs

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.9 -0.01];
ft_databrowser(cfg, data);
 
%% Remove bad epochs


cfg = [];
cfg.artfctdef.reject = 'complete';
new_paired = [1 3 18 25 27 28 30 39 40 56 59 66 76 87 92 93 96 100 101 115];
new_single = [14 15 16 17 23 28 29 43 51 53 56 69 76 78 82 88 94 102 103];
JH_LICI_47 = [3 5 38 39 61 81 103 112 110 41 47 69];
JH_single35_ref_n_gnd = [7 20 32];
JH_single35 = [1 8 24 38 42 44 58 101 102];
JH_single_47 = [1 2 102 103 107 111 112 113];
old_single = [1 2 12 14 15 16 22 24 30 31  32 36 40 44 45 51 53 54 64 67 71 72 73];
old_LICI = [1  32 33 46 56 64 68 76 78 87 89 90 91 92 93 94];
rejectArray = old_LICI;
cfg.artfctdef.xxx.artifact = ft_xxxReject(rejectArray , data.fsample);
numEpochsRmv = length(rejectArray);
data = ft_rejectartifact(cfg, data);

trl = data.cfg.trl;



%% set rejection markers

%type is 1 if single pulse or 2 if paired pulse
type = 2;


if type ==1
    cfg = [];
    cfg.trl = trl;
    cfg.continuous = 'no';
    cfg.method = 'marker';
     if data_set == 1 || data_set ==0
        cfg.prestim = 0;
    elseif data_set == 2
        cfg.prestim = -0.007;
    end
  
    [cutoff cutinterval time] = ft_getCutoff(data, cfg, type)  % 1 if single pulse, 2 if double pulse
    %cutoff = 0.017;
    cfg.poststim = 0.023;
    cfg.Fs = 5000;
    triggers = {'S  1', 'S  2'};
    cfg.trialdef.eventtype      = 'Stimulus'; % see above
    cfg.trialdef.eventvalue     = triggers ;
    %cfg.trialdef.eventtype  = 'p-pulse';
    %cfg.trialdef.eventvalue = 1000;
    cfg.trialfun = 'ft_markpulse';
    [cfg_artifact, artifact] = ft_artifact_tms(cfg, data);
    
    % reject artifact
    cfg_artifact.artfctdef.reject = 'partial';
    cfg_artifact.artfctdef.minaccepttim = 0.01;
    data = ft_rejectartifact(cfg_artifact, data);
    
end


if type ==2
    
    %remove the second pulse
    cfg = [];
    cfg.trl = trl;
    cfg.continuous = 'no';
    cfg.method = 'marker';
    
    cfg.prestim = -0.098;
    prestim = cfg.prestim;
    [cutoff cutinterval time] = ft_getCutoff(data, cfg, type)  % 1 if single pulse, 2 if double pulse
    cfg.poststim = 0.123;
    cfg.Fs = 5000;
    cfg.trialdef.eventtype  = 'p-pulse';
    cfg.trialdef.eventvalue = 1000;
    cfg.trialfun = 'ft_markpulse';
    [cfg_artifact, artifact] = ft_artifact_tms(cfg, data);
    
    % reject artifact
    cfg_artifact.artfctdef.reject = 'partial';
    cfg_artifact.artfctdef.minaccepttim = 0.01;
    data = ft_rejectartifact(cfg_artifact, data);
    
    % remove first pulse
    cfg = [];
    cfg.trl = trl;
    cfg.continuous = 'no';
    cfg.method = 'marker';
    cfg.prestim = 0.002;
    
    cfg.poststim = 0.035;
    cfg.Fs = 5000;
    cfg.trialdef.eventtype  = 'p-pulse';
    cfg.trialdef.eventvalue = 1000;
    cfg.trialfun = 'ft_markpulse';
    [cfg_artifact, artifact] = ft_artifact_tms(cfg, data);
    
    % reject artifact
    cfg_artifact.artfctdef.reject = 'partial';
    cfg_artifact.artfctdef.minaccepttim = 0.01;
    data = ft_rejectartifact(cfg_artifact, data);
end

 
%% Browse the data 
 
cfg = [];
 cfg.preproc.demean = 'yes';
 cfg.preproc.baselinewindow = [-1 -0.01];
 cfg.layout = 'easycapM23.lay';
 ft_databrowser(cfg, data);
 
 
%% Display the segmented data including the artifacts that are gone
 %
 
 cfg = [];
cfg.artfctdef = cfg_artifact.artfctdef; % Store previously obtained artifact definition
cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data);



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
cfg.layout    = 'easycapM23'; % If you use a function that requires plotting of topographical information you need to supply the function with the location of your channels
ft_topoplotIC(cfg, comp_tms);

figure;
cfg = [];
cfg.viewmode = 'vertical';
ft_databrowser(cfg, comp_tms);
%% frequency analysis

cfg = [];
cfg.polyremoval     = 1; % Removes mean and linear trend
cfg.output          = 'pow'; % Output the powerspectrum
cfg.method          = 'mtmconvol';  
cfg.taper           = 'hanning';
cfg.foi             = 1:30; % Our frequencies of interest. Now: 1 to 50, in steps of 1.
cfg.t_ftimwin       = 0.3.*ones(1,numel(cfg.foi));
cfg.toi             = -0.5:0.05:1.5;

freq         = ft_freqanalysis(cfg, comp_tms);

%%
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

        %% Use unmixing matrix to get original data back to remove components

cfg          = [];
cfg.demean   = 'no'; % This has to be explicitly stated as the default is to demean.
cfg.unmixing = comp_tms.unmixing; % Supply the matrix necessay to 'unmix' the channel-series data into components
cfg.topolabel = comp_tms.topolabel; % Supply the original channel label information
 
comp_tms         = ft_componentanalysis(cfg, data);  % MAKE SURE THIS IS SUPPOSED TO BE DATA_VISUAL AND NOT COMP_TMS

%% Reject components

cfg            = [];
 removeArray    = [25 1 2 7]; 
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


%% Interpolate the data

if type == 1 
% Replacing muscle artifact with nans
    muscle_window = [0 0.023]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
    for i=1:size(data_tms_clean.trial,2) % Loop through all trials
      data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
end


      %% Interpolate the data for the second pulse
if type ==2
% Replacing muscle artifact with nans
    muscle_window = [-0.002 0.035]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
    for i=1:size(data_tms_clean.trial,2) % Loop through all trials
      data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
% Replacing muscle artifact with nans
    muscle_window = [0.098 0.123]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))]; % Find the indices in the time vector corresponding to our window of interest
    for i=1:size(data_tms_clean.trial,2) % Loop through all trials
      data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
end 
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
cfg.preproc.type = 'firws';
data_filt = ft_preprocessing(cfg, data_tms_clean);


 %% find bad Epochs
 
 cfg = [];
 cfg.preproc.demean = 'yes';
 cfg.preproc.detrend = 'yes';
 cfg.preproc.baselinewindow = [-1 -0.01];
 
 ft_databrowser(cfg, data_filt);
 

%% test for artifact rejection 

cfg = [];
cfg.artfctdef.reject = 'complete';
rejectArray = [70 73];
cfg.artfctdef.xxx.artifact = ft_xxxReject(rejectArray, data.fsample);

numEpochsRmv2 = size(rejectArray,2);

data_filt = ft_rejectartifact(cfg, data_filt);

trl = data.cfg.trl;

data_tms_clean = data_filt;

%% browse data

 cfg.preproc.demean = 'no'
 %cfg.layout = 'easycapM23.lay';
 ft_databrowser(cfg, data_filt);
 


%% Convert back to EEGLAB

fieldtrip2eeglab
chanNumEnd = size(EEG.data,1);

logData( title, type, chanNumStart, chanNumEnd, numEpochs, numEpochsRmv, cutoff, numComp, numCompRmv, numEpochsRmv2)
   %% Remove any nan trials

EEG = remove_nan_trial(EEG);



%% For 

