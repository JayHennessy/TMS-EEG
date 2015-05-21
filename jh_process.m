addpath '/Users/jay/Documents/MATLAB/fieldtrip-20150507'
addpath '/Users/jay/Documents/MATLAB/fieldtrip-20150507/utilities'
addpath '/Users/jay/Desktop/Work/EEG_tests/s13'   % make this which ever path leads to the data being processed
fileName = '1501_s13_M1.eeg';

prompt = '\n Please define the pulse paradigme to be analyzed (1, 2, 3, 4) . \n\n';
pulseType = input(prompt);

switch pulseType
    case 1
        triggers = {'S  1'};
    case 2
        triggers = {'S  2'};
    case 3
        triggers = {'S  3'};
    case 4
        triggers = {'S  4'};
end

 
cfg = [];
cfg.dataset                 = fileName;
cfg.continuous              = 'yes';
cfg.trialdef.prestim        = .5;         % prior to event onset
cfg.trialdef.poststim       = 1.5;        % after event onset
cfg.trialdef.eventtype      = 'Stimulus'; % see above
cfg.trialdef.eventvalue     = triggers ;
cfg = ft_definetrial(cfg);                % make the trial definition matrix

trl = cfg.trl;

cfg.channel = {'all' '-FC6' '-POz' '-CPz'}; % indicate the channels we would like to read and/or exclude.
cfg.reref = 'yes';        % We want to rereference our data
cfg.refchannel = {'all'}; % Here we specify our reference channels
cfg.implicitref = 'FCz';    % Here we can specify the name of the implicit reference electrode used during the acquisition
 
data_tms_raw = ft_preprocessing(cfg);

%look at data, here you can identify eye blinks, or wait for ICA

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.001];
ft_databrowser(cfg, data_tms_raw);

chans = 0;

while chans == 0

    cfg.blocksize = 2;
    cfg.continuous = 'no';
    ft_databrowser(cfg, data_tms_raw);
    prompt = '\n \n Please enter a cell array containing the names of the bad channels \n \n ';
    badChannels = input(prompt);



    badChanCell = cell(1,size(badChannels,2)+1);
    badChanCell{1} = 'all';
    for i = 1:size(badChannels,2)
        x = i+1;
        badChanCell{x} = strcat('-',badChannels{i});
    end
    
    selchan = ft_channelselection(badChanCell, data_tms_raw.label);
    data_tms_raw = ft_selectdata(data_tms_raw, 'channel', selchan);  

        
cfg.blocksize = 2;
cfg.demean = 'yes';
cfg.continuous = 'no'; 
ft_databrowser(cfg, data_tms_raw);   
prompt = '\n \n Are you pleased with the result?  [1 = y / 0 = n] \n \n ';
chans = input(prompt);

end



prompt = '\n \n Please enter the bad trials. \n \n';
badTrials = input(prompt);

cfg_artifact = [];

for i = 1:length(badTrials)
    cfg_artifact.artfctdef.badTrial.artifact(i,1) = trl(badTrials(i),1); 
    cfg_artifact.artfctdef.badTrial.artifact(i,2) = trl(badTrials(i),2);    
end


cfg_artifact.artfctdef.reject = 'complete'; % Can also be 'complete', or 'nan';
cfg_artifact.trl = trl; % We supply ft_rejectartifact with the original trial structure so it knows where to look for artifacts.
cfg_artifact.artfctdef.minaccepttim = 0.01; % This specifies the minimumm size of resulting trials. You have to set this, the default is too large for thre present data, resulting in small artifact-free segments being rejected as well.
data_tms_raw = ft_rejectartifact(cfg_artifact,data_tms_raw); % R

% Make an average to easily identify TMS pulse

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.001];
 data_tms_avg = ft_timelockanalysis(cfg, data_tms_raw);
 
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.001];
ft_databrowser(cfg, data_tms_avg);

% here we can clear data_tms_raw (note: it should be saved earlier)
%clear data_tms_raw;

prompt = '\n \n At what latency should the TMS artifact be cut? (usually ~10ms) \n \n';
latency = input(prompt);

%identify TMS artifact

% Ringing/Step Response artifact
trigger = {'S  1'};              % Markers in data that reflect TMS-pulse onset
cfg                         = [];
cfg.method                  = 'marker'; % The alternative is 'detect' to detect the onset of pulses
cfg.dataset                 = fileName;
cfg.prestim                 = 0;     % First time-point of range to exclude
cfg.poststim                = latency;     % Last time-point of range to exclude
cfg.trialdef.eventtype      = 'Stimulus';
cfg.trialdef.eventvalue     = trigger ;
cfg_ringing_s1 = ft_artifact_tms(cfg);     % Detect TMS artifacts

% Here we use a negative value because the recharging artifact starts AFTER TMS-pulse onset
trigger = {'S  2'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = -0.1; 
cfg.poststim  = latency+0.1;
cfg_ringing_s2  = ft_artifact_tms(cfg); % Detect TMS artifacts 

trigger = {'S  2'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = 0; 
cfg.poststim  = .03;
cfg_ringing_s2_a  = ft_artifact_tms(cfg); % Detect TMS artifacts 

trigger = {'S  3'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = 0; 
cfg.poststim  = latency+0.011;
cfg_ringing_s3  = ft_artifact_tms(cfg); % Detect TMS artifacts 

trigger = {'S  4'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = 0; 
cfg.poststim  = latency+0.001;
cfg_ringing_s4  = ft_artifact_tms(cfg); % Detect TMS artifacts

% Combine into one structure
cfg_artifact = [];
cfg_artifact.dataset = fileName;
cfg_artifact.artfctdef.ringing.artifact = vertcat(cfg_ringing_s1.artfctdef.tms.artifact,cfg_ringing_s2.artfctdef.tms.artifact,cfg_ringing_s3.artfctdef.tms.artifact,cfg_ringing_s4.artfctdef.tms.artifact); % Add ringing/step response artifact definition


cfg_artifact.artfctdef.ringing_s1.artifact = cfg_ringing_s1.artfctdef.tms.artifact; % Add ringing/step response artifact definition
cfg_artifact.artfctdef.ringing_s2.artifact = cfg_ringing_s2.artfctdef.tms.artifact;
cfg_artifact.artfctdef.ringing_s2_a.artifact = cfg_ringing_s2_a.artfctdef.tms.artifact;
cfg_artifact.artfctdef.ringing_s3.artifact = cfg_ringing_s3.artfctdef.tms.artifact;
cfg_artifact.artfctdef.ringing_s4.artifact = cfg_ringing_s4.artfctdef.tms.artifact;




% reject the TMS artifact

cfg_artifact.artfctdef.reject = 'partial'; % Can also be 'complete', or 'nan';
cfg_artifact.trl = trl; % We supply ft_rejectartifact with the original trial structure so it knows where to look for artifacts.
cfg_artifact.artfctdef.minaccepttim = 0.01; % This specifies the minimumm size of resulting trials. You have to set this, the default is too large for thre present data, resulting in small artifact-free segments being rejected as well.
cfg = ft_rejectartifact(cfg_artifact); % Reject trials partially

cfg.channel = {'all' '-FC6' '-POz' '-CPz'};
cfg.reref       = 'yes';
cfg.refchannel  = {'all'};
cfg.implicitref = 'FCz';
data_tms_segmented  = ft_preprocessing(cfg,data_tms_raw);

% Browse data without artifacts

cfg = [];
cfg.demean = 'yes';
cfg.artfctdef = cfg_artifact.artfctdef; % Store previously obtained artifact definition
cfg.continuous = 'no'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data_tms_segmented);

% resample into new data structure
cfg                      = [];
cfg.resamplefs           = 1000; % Frequency to resample to
cfg.demean               = 'yes';
data_tms_segmented_resampled = ft_resampledata(cfg, data_tms_segmented);


% Perform ICA on segmented data
cfg = [];
cfg.demean = 'yes'; 
cfg.method = 'fastica';        % FieldTrip supports multiple ways to perform ICA, 'fastica' is one of them.
cfg.fastica.approach = 'symm'; % All components will be estimated simultaneously.
cfg.fastica.g = 'gauss'; 

% might need to downsample here ****************
 
comp_tms = ft_componentanalysis(cfg, data_tms_segmented_resampled);

% checkout the data

cfg = [];
cfg.vartrllength  = 2; % This is necessary as our trials are in fact segments of our original trials. This option tells the function to reconstruct the original trials based on the sample-information stored in the data
comp_tms_avg = ft_timelockanalysis(cfg, comp_tms);


figure;
cfg = [];
cfg.viewmode = 'butterfly';
ft_databrowser(cfg, comp_tms_avg);

figure;
cfg = [];
cfg.plotlabels = 'yes';
cfg.viewmode = 'vertical';
ft_databrowser(cfg, comp_tms);

 % frequency analysis
 
 
 cfg = [];
 cfg.polyremoval     = 1; % Removes mean and linear trend
 cfg.output          = 'pow'; % Output the powerspectrum
 cfg.method          = 'mtmconvol';
 cfg.taper           = 'hanning';
 cfg.foi             = 1:3:69; % Our frequencies of interest. Now: 1 to 50, in steps of 1.
 cfg.t_ftimwin       = 0.3.*ones(1,numel(cfg.foi));
 %cfg.toi             = -0.5:0.05:1.5;
 cfg.toi             = 0:0.0002:0.8932;
 
 
 freq = ft_freqanalysis(cfg, comp_tms);
 
 
 tmpLabels = freq.label;
 for i = 1:size(comp_tms.label,1)
     freq.label{i} = comp_tms.label{i};
 end
 
 cfg = [];
 cfg.xlim = [0 1.0]; % Specify the time range to plot
 cfg.zlim = [-500 500];
 cfg.layout = 'ordered';
 cfg.showlabels = 'yes';
 cfg.interactve = 'yes';
 
 figure;
 ft_multiplotTFR(cfg, freq);

%look at head map
figure;
cfg           = [];
cfg.component = [1:size(comp_tms.topo,2)];  % might not necesarilly be 60 components
cfg.comment   = 'no';
cfg.layout    = 'easycap_J61'; % Need to find our own layout using the neuronav info
ft_topoplotIC(cfg, comp_tms);


% unmix data before we put it back together
cfg          = [];
cfg.demean   = 'no'; % This has to be explicitly stated as the default is to demean.
cfg.unmixing = comp_tms.unmixing; % Supply the matrix necessay to 'unmix' the channel-series data into components
cfg.topolabel = comp_tms.topolabel; % Supply the original channel label information
 
comp_tms          = ft_componentanalysis(cfg, data_tms_segmented);


prompt = '\n \n Please enter the bad components. \n \n';
badComps = input(prompt)

%remove compoenents
cfg            = [];
cfg.component  = badComps;  
cfg.demean     = 'no';
 
data_tms_clean_segmented = ft_rejectcomponent(cfg, comp_tms);

% Interpolate data
% Apply original structure to segmented data, gaps will be filled with nans
cfg     = [];
cfg.trl = trl;
data_tms_clean = ft_redefinetrial(cfg, data_tms_clean_segmented); % Restructure cleaned data


% Replacing muscle artifact with nans

if pulseType ==1
    muscle_window = [0 latency]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))];
    for i=1:numel(data_tms_clean.trial) % Loop through all trials
        data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
elseif pulseType ==2
    muscle_window = [0 0.03]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))];
    for i=1:numel(data_tms_clean.trial) % Loop through all trials
        data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
    muscle_window = [0.1 latency+0.1]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))];
    for i=1:numel(data_tms_clean.trial) % Loop through all trials
        data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
elseif pulseType ==3
    muscle_window = [0 latency+0.011]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))];
    for i=1:numel(data_tms_clean.trial) % Loop through all trials
        data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
elseif pulseType ==4
    muscle_window = [0 latency+0.001]; % The window we would like to replace with nans
    muscle_window_idx = [nearest(data_tms_clean.time{1},muscle_window(1)) nearest(data_tms_clean.time{1},muscle_window(2))];
    for i=1:numel(data_tms_clean.trial) % Loop through all trials
        data_tms_clean.trial{i}(:,muscle_window_idx(1):muscle_window_idx(2))=nan; % Replace the segment of data corresponding to our window of interest with nans
    end;
end;






% Interpolate nans using cubic interpolation
cfg = [];
cfg.method = 'pchip'; % Here you can specify any method that is supported by interp1: 'nearest','linear','spline','pchip','cubic','v5cubic'
cfg.prewindow = 0.01; % Window prior to segment to use data points for interpolation
cfg.postwindow = 0.01; % Window after segment to use data points for interpolation
data_tms_clean = ft_interpolatenan(cfg, data_tms_clean); % Clean data
 
% compute the TEP on the cleaned data
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.05 -0.001];
 
data_tms_clean_avg = ft_timelockanalysis(cfg, data_tms_clean);

figure;
plot(data_tms_clean_avg.time, data_tms_clean_avg.avg(17,:)); % Plot all data
    xlim([-0.1 0.6]); % Here we can specify the limits of what to plot on the x-axis
   % ylim([-23 15]); % Here we can specify the limits of what to plot on the y-axis
    title(['Channel ' data_tms_avg.label{17}]);
    ylabel('Amplitude (uV)')
    xlabel('Time (s)');
