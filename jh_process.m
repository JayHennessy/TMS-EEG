triggers = {'S  1','S  2', 'S  3','S  4'}; % These values correspond to the markers placed in this dataset
 
cfg = [];
cfg.dataset                 = '1501_s11_M1.eeg';
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
cfg.implicitref = '52';    % Here we can specify the name of the implicit reference electrode used during the acquisition
 
data_tms_raw = ft_preprocessing(cfg);

%look at data, here you can identify eye blinks, or wait for ICA
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.001];
ft_databrowser(cfg, data_tms_raw);

% Make an average to easily identify TMS pulse
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.001];
 
data_tms_avg = ft_timelockanalysis(cfg, data_tms_raw);

% here we can clear data_tms_raw (note: it should be saved earlier)
clear data_tms_raw;

%identify TMS artifact

% Ringing/Step Response artifact
trigger = {'S  1','S  2','S  3', 'S  4'};              % Markers in data that reflect TMS-pulse onset
cfg                         = [];
cfg.method                  = 'marker'; % The alternative is 'detect' to detect the onset of pulses
cfg.dataset                 = '1501_s11_M1.eeg';
cfg.prestim                 = -.003;     % First time-point of range to exclude
cfg.poststim                = .011;     % Last time-point of range to exclude
cfg.trialdef.eventtype      = 'Stimulus';
cfg.trialdef.eventvalue     = trigger ;
cfg_ringing = ft_artifact_tms(cfg);     % Detect TMS artifacts

% Here we use a negative value because the recharging artifact starts AFTER TMS-pulse onset
trigger = {'S  2'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = -.1; 
cfg.poststim  = .11;
cfg_recharge  = ft_artifact_tms(cfg); % Detect TMS artifacts 

trigger = {'S  3'};
cfg.trialdef.eventvalue     = trigger ;
cfg.prestim   = -.011; 
cfg.poststim  = .023;
cfg_recharge  = ft_artifact_tms(cfg); % Detect TMS artifacts 

% Combine into one structure
cfg_artifact = [];
cfg_artifact.dataset = '1501_s11_M1.eeg';
cfg_artifact.artfctdef.ringing.artifact = cfg_ringing.artfctdef.tms.artifact; % Add ringing/step response artifact definition
cfg_artifact.artfctdef.recharge.artifact   = cfg_recharge.artfctdef.tms.artifact; % Add recharge artifact definition

% reject the TMS artifact

cfg_artifact.artfctdef.reject = 'partial'; % Can also be 'complete', or 'nan';
cfg_artifact.trl = trl; % We supply ft_rejectartifact with the original trial structure so it knows where to look for artifacts.
cfg_artifact.artfctdef.minaccepttim = 0.01; % This specifies the minimumm size of resulting trials. You have to set this, the default is too large for thre present data, resulting in small artifact-free segments being rejected as well.
cfg = ft_rejectartifact(cfg_artifact); % Reject trials partially

cfg.channel = {'all' '-FC6' '-POz' '-CPz'};
cfg.reref       = 'yes';
cfg.refchannel  = {'all'};
cfg.implicitref = '52';
data_tms_segmented  = ft_preprocessing(cfg);

% Browse data without artifacts

cfg = [];
cfg.artfctdef = cfg_artifact.artfctdef; % Store previously obtained artifact definition
cfg.continuous = 'yes'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data_tms_segmented);

% Perform ICA on segmented data
cfg = [];
cfg.demean = 'yes'; 
cfg.method = 'fastica';        % FieldTrip supports multiple ways to perform ICA, 'fastica' is one of them.
cfg.fastica.approach = 'symm'; % All components will be estimated simultaneously.
cfg.fastica.g = 'gauss'; 
 
comp_tms = ft_componentanalysis(cfg, data_tms_segmented);
