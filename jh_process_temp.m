addpath '/Users/jay/Documents/MATLAB/fieldtrip-20150507'
addpath '/Users/jay/Documents/MATLAB/fieldtrip-20150507/utilities'
%addpath '/Users/jay/Desktop/Work/EEG_tests/s13'   % make this which ever path leads to the data being processed
fileName = '1501_s14_DLPFC.eeg';


prestim = 0.5;  
poststim = 1;
triggers = {'S  1' , 'S  2','S  3','S  4'};

% record info about the subject
if strfind(fileName, 'DLPFC')
    subjectInfo.stimLoc = 'DLPFC';
elseif strfind(fileName, 'M1')
    subjectInfo.stimLoc = 'M1';
else
    display(' ## could not find M1 or DLPFC in filename, M1 was assumed##');
    subjectInfo.stimLoc = 'M1';
end

x = strfind(fileName, '_s')
subjectInfo.No = fileName(x+2:x+3);


cfg = [];
cfg.dataset                 = fileName;
cfg.continuous              = 'yes';
cfg.fsample                 = 5000;       % this is the sampling rate
cfg.trialdef.prestim        = prestim;         % prior to event onset
cfg.trialdef.poststim       = poststim;        % after event onset
cfg.trialdef.eventtype      = 'Stimulus'; % see above
cfg.trialdef.eventvalue     = triggers ;
cfg.trialfun                = 'jh_trialfun_all';
cfg = ft_definetrial(cfg);                % make the trial definition matrix

trl = cfg.trl;

cfg.channel = {'all' '-FC6' '-POz' '-CPz'}; % indicate the channels we would like to read and/or exclude.
cfg.reref = 'yes';        % We want to rereference our data
cfg.refchannel = {'all'}; % Here we specify our reference channels
cfg.implicitref = 'FCz';    % Here we can specify the name of the implicit reference electrode used during the acquisition

data_tms_raw = ft_preprocessing(cfg);
subjectInfo.beginningTrials = length(data_tms_raw.trial);
%look at data, here you can identify eye blinks, or wait for ICA

cfg = [];   
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.01];
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

subjectInfo.badChannels = badChannels;
%****** this data is good until here at least

% Make an average to easily identify TMS pulse
for i  = 1:4
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.01];
cfg.trials  = find(data_tms_raw.trialinfo == i);
data_tms_avg = ft_timelockanalysis(cfg, data_tms_raw);

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.1 -0.01];
ft_databrowser(cfg, data_tms_avg);
end
% here we can clear data_tms_raw (note: it should be saved earlier)
%clear data_tms_raw;

prompt = '\n \n At what latency should the TMS artifact be cut? (usually ~0.01s) \n \n';
latency = input(prompt);
subjectInfo.pulseDuration = latency;

% %identify TMS artifact

% Ringing/Step Response artifact
trigger = {'S  1','S  2','S  3','S  4'};              % Markers in data that reflect TMS-pulse onset
cfg                         = [];
cfg.method                  = 'marker'; % The alternative is 'detect' to detect the onset of pulses
cfg.trialfun                = 'jh_trialfun_tms';
cfg.dataset                 = fileName;
cfg.data                    = data_tms_raw;
cfg.prestim                 = 0.000;     % First time-point of range to exclude
cfg.poststim                = latency;     % Last time-point of range to exclude
cfg.trialdef.eventtype      = 'Stimulus';
cfg.trialdef.eventvalue     = trigger ;
cfg_tms_artifact = ft_artifact_tms(cfg);     % Detect TMS artifacts

cfg_artifact = [];
cfg_artifact.artfctdef.ringing.artifact = cfg_tms_artifact.artfctdef.tms.artifact;

% reject the TMS artifact

cfg_artifact.artfctdef.reject = 'partial'; % Can also be 'complete', or 'nan';
cfg_artifact.trl = trl; % We supply ft_rejectartifact with the original trial structure so it knows where to look for artifacts.
cfg_artifact.artfctdef.minaccepttim = 0.01; % This specifies the minimumm size of resulting trials. You have to set this, the default is too large for thre present data, resulting in small artifact-free segments being rejected as well.
data_tms_segmented = ft_rejectartifact(cfg_artifact, data_tms_raw); % Reject trials partially

trl_segmented = data_tms_segmented.cfg.trl;
trl2 = trl_segmented;

clear data_tms_raw;

% insert trial rejection here

% jump artifect
cfg                    = [];
cfg.trl = data_tms_segmented.cfg.trl;

% channel selection, cutoff and padding
cfg.artfctdef.zvalue.channel    = 'EEG';
cfg.artfctdef.zvalue.cutoff     = 30;
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

[cfg, artifact_jump] = ft_artifact_zvalue(cfg,data_tms_segmented);


% muscle
cfg            = [];
cfg.trl = data_tms_segmented.cfg.trl;

% channel selection, cutoff and padding
cfg.artfctdef.zvalue.channel    = 'EEG';
cfg.artfctdef.zvalue.cutoff      = 18;
cfg.artfctdef.zvalue.trlpadding  = 0;
cfg.artfctdef.zvalue.fltpadding  = 0;
cfg.artfctdef.zvalue.artpadding  = 0;

% algorithmic parameters
cfg.artfctdef.zvalue.bpfilter    = 'yes';
cfg.artfctdef.zvalue.bpfreq      = [110 140];
cfg.artfctdef.zvalue.bpfiltord   = 11;
cfg.artfctdef.zvalue.bpfilttype  = 'fir';
cfg.artfctdef.zvalue.hilbert     = 'yes';
cfg.artfctdef.zvalue.boxcar      = 0.2;

% make the process interactive
cfg.artfctdef.zvalue.interactive = 'yes';

[cfg, artifact_muscle] = ft_artifact_zvalue(cfg,data_tms_segmented);

% close all the figures
close all

cfg     = [];
cfg.trl = trl;
data_tms_trimmed = ft_redefinetrial(cfg, data_tms_segmented);
subjectInfo.removedTrials = length(data_tms_segmented.trial) -length(data_tms_trimmed.trial);

cfg = [];
cfg.preproc.baselinewindow = [-0.1 -0.01];
cfg.preproc.demean = 'yes';
cfg.viewmode = 'butterfly';
cfg.artfctdef.artifact_muscle.artifact = artifact_muscle;
cfg.artfctdef.artifact_jump.artifact = artifact_jump;
cfg.continuous = 'no'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data_tms_trimmed);


prompt = '\n \n Please enter the bad trials. \n \n';
badTrialsHand = input(prompt);

cfg =[];



for i = 1:length(badTrialsHand)
    cfg.artfctdef.badTrial.artifact(i,1) = trl(badTrialsHand(i),1);
    cfg.artfctdef.badTrial.artifact(i,2) = trl(badTrialsHand(i),2);
end

cfg.artfctdef.artifact_jump.artifact = artifact_jump;
cfg.artfctdef.artifact_muscle.artifact = artifact_muscle;

% reject the bad trials picked by hand and automatically

cfg.artfctdef.reject = 'complete'; % Can also be 'complete', or 'nan';
cfg.trl = trl; % We supply ft_rejectartifact with the original trial structure so it knows where to look for artifacts.
cfg.artfctdef.minaccepttim = 0.01; % This specifies the minimumm size of resulting trials. You have to set this, the default is too large for thre present data, resulting in small artifact-free segments being rejected as well.
data_tms_trimmed = ft_rejectartifact(cfg,data_tms_trimmed); % R

trl_trimmed = data_tms_trimmed.cfg.trl;


% update the trl_segmented definition to exclude the rejected trials
% first identify the hand picked trials
count =1;
i =1;
while i<=length(badTrialsHand)
    if pulseType ==2
        badTrials(count) = 3*badTrialsHand(i)-1;
        badTrials(count+1) = 3*badTrialsHand(i);
        badTrials(count+2) = 3*badTrialsHand(i)-2;
        count = count+3;
    else
        badTrials(count) = 2*badTrialsHand(i)-1;
        badTrials(count+1) = 2*badTrialsHand(i);
        count = count+2;
    end
    i= i+1;
end

% then identify the automatically picked trials
if pulseType == 2
   
    artifact_all = cat(1,artifact_jump, artifact_muscle);
    i=1;
    j=1;
    while i <= length(trl_segmented)
        j = 1;
        while j <= length(artifact_all)
            if trl_segmented(i,1) <= artifact_all(j,1) && artifact_all(j,1) <= trl_segmented(i,2)
                if mod(i,3)==0
                    badTrials(end+1) = i;
                    badTrials(end+1) = i-1;
                    badTrials(end+1) = i-2;
                    break;
                elseif mod(i,3) ==1
                    badTrials(end+1) = i;
                    badTrials(end+1) = i+1;
                    badTrials(end+1) = i+2;
                    break;
                elseif mod(i,3) ==2
                    badTrials(end+1) = i;
                    badTrials(end+1) = i-1;
                    badTrials(end+1) = i+1;
                    break;
                end
                
            end
            j= j+1;
        end
        i = i+1;
    end
   
else
    artifact_all = cat(1,artifact_jump, artifact_muscle);
    i=1;
    j=1;
    while i <= length(trl_segmented)
        j = 1;
        while j <= length(artifact_all)
            if trl_segmented(i,1) <= artifact_all(j,1) && artifact_all(j,1) <= trl_segmented(i,2)
                if mod(i,2)==0
                    badTrials(end+1) = i;
                    badTrials(end+1) = i-1;  
                    break;
                else
                    badTrials(end+1) = i;
                    badTrials(end+1) = i+1;  
                    break;
                end
            end
            j= j+1;
        end
        i = i+1;
    end
end
    
badTrials= unique(badTrials);

% remove trials from the trl definition
trl_segmented(badTrials,:) = [];
subjectInfo.removedTrials = subjectInfo.removedTrials + length(badTrials);


% re-define to the segmented version of the data but now without bad trials

cfg = [];
cfg.trl = trl_segmented;
data_tms_segmented = ft_redefinetrial(cfg, data_tms_trimmed);

% Browse data without artifacts

cfg = [];
cfg.demean = 'yes';
cfg.continuous = 'no'; % Setting this to yes forces ft_databrowser to represent our segmented data as one continuous signal
ft_databrowser(cfg, data_tms_segmented);


% resample into new data structure
cfg                      = [];
cfg.resamplefs           = 500; % Frequency to resample to
cfg.demean               = 'yes';
data_tms_segmented_resampled = ft_resampledata(cfg, data_tms_segmented);

% close opened figures
close all

% Perform ICA on segmented data
cfg = [];
cfg.demean = 'yes'; 
cfg.method = 'fastica';        % FieldTrip supports multiple ways to perform ICA, 'fastica' is one of them.
cfg.fastica.numOfIC = length(data_tms_segmented.label);
cfg.fastica.approach = 'symm'; % All components will be estimated simultaneously.
cfg.fastica.g = 'gauss'; 

% might need to downsample here ****************
 
comp_tms = ft_componentanalysis(cfg, data_tms_segmented_resampled);
subjectInfo.numComponents = length(comp_tms.topo);

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
% cfg.renderer = 'painters'  % use this if the analysis is on a PC
cfg.plotlabels = 'yes';
cfg.viewmode = 'component';
cfg.layout    = 'easycap_J61';
ft_databrowser(cfg, comp_tms);


 % frequency analysis
 
 
 cfg = [];
 cfg.polyremoval     = 1; % Removes mean and linear trend
 cfg.output          = 'pow'; % Output the powerspectrum
 cfg.method          = 'mtmconvol';
 cfg.taper           = 'hanning';
 cfg.foi             = 1:1:69; % Our frequencies of interest. Now: 1 to 50, in steps of 1.
 %cfg.t_ftimwin       = prestim+poststim/numel(cfg.foi).*ones(1,numel(cfg.foi));
 cfg.t_ftimwin       = 0.1*ones(1,numel(cfg.foi));
 cfg.toi             = -prestim:0.002:poststim-0.0002;
 %cfg.toi             = 0:0.0002:0.8932;
 
 
 
 freq = ft_freqanalysis(cfg, comp_tms);
 
 
 tmpLabels = freq.label;
 for i = 1:size(comp_tms.label,1)
     freq.label{i} = comp_tms.label{i};
 end
 
 cfg = [];
 cfg.xlim =  'maxmin' % Specify the time range to plot
 m = freq.powspctrm;
 m(isnan(m)) = [];
 yh = mean(mean(mean(prctile(m, 98))))
 yl = mean(mean(mean(prctile(m, 2))))

 cfg.zlim =   [yl yh];
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
subjectInfo.componentUnmixing = comp_tms.unmixing;
comp_tms          = ft_componentanalysis(cfg, data_tms_segmented);


prompt = '\n \n Please enter the bad components. \n \n';
badComps = input(prompt)

%remove compoenents
cfg            = [];
cfg.component  = badComps;  
cfg.demean     = 'no';

data_tms_clean_segmented = ft_rejectcomponent(cfg, comp_tms);
subjectInfo.badComponents = badComps;

% Interpolate data
% Apply original structure to segmented data, gaps will be filled with nans
cfg     = [];
cfg.trl = trl_trimmed;
data_tms_clean = ft_redefinetrial(cfg, data_tms_clean_segmented); % Restructure cleaned data
clear data_tms_clean_segmented;

% close all the opened figures
close all

% Interpolate nans using cubic interpolation
cfg = [];
cfg.method = 'pchip'; % Here you can specify any method that is supported by interp1: 'nearest','linear','spline','pchip','cubic','v5cubic'
cfg.prewindow = 0.01; % Window prior to segment to use data points for interpolation
cfg.postwindow = 0.01; % Window after segment to use data points for interpolation
data_tms_clean = ft_interpolatenan(cfg, data_tms_clean); % Clean data
% data_tms_clean.time = -prestim:1/data_tms_clean.fsample:poststim-1/data_tms_clean.fsample;

cfg = [];
cfg.bpfilter = 'yes';
cfg.dftfilter = 'yes';
cfg.bpfreq = [0.3 80];
cfg.dftfreq = [60 120 180];
cfg.bpfilttype = 'firws';
data_tms_clean = ft_preprocessing(cfg, data_tms_clean);
 
% compute the TEP on the cleaned data
cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.5 -0.01];
cfg.trials = find(data_tms_clean.trialinfo==1);
data_tms_clean_avg1 = ft_timelockanalysis(cfg, data_tms_clean);
data_tms_clean_avg1.prestim = prestim;
data_tms_clean_avg1.poststim = poststim;
data_tms_clean_avg1.subjectInfo = subjectInfo;

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.5 -0.01];
cfg.trials = find(data_tms_clean.trialinfo==2);
data_tms_clean_avg2 = ft_timelockanalysis(cfg, data_tms_clean);
data_tms_clean_avg2.prestim = prestim;
data_tms_clean_avg2.poststim = poststim;
data_tms_clean_avg2.subjectInfo = subjectInfo;

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.5 -0.01];
cfg.trials = find(data_tms_clean.trialinfo==3);
data_tms_clean_avg3 = ft_timelockanalysis(cfg, data_tms_clean);
data_tms_clean_avg3.prestim = prestim;
data_tms_clean_avg3.poststim = poststim;
data_tms_clean_avg3.subjectInfo = subjectInfo;

cfg = [];
cfg.preproc.demean = 'yes';
cfg.preproc.baselinewindow = [-0.5 -0.01];
cfg.trials = find(data_tms_clean.trialinfo==4);
data_tms_clean_avg4 = ft_timelockanalysis(cfg, data_tms_clean);
data_tms_clean_avg4.prestim = prestim;
data_tms_clean_avg4.poststim = poststim;
data_tms_clean_avg4.subjectInfo = subjectInfo;

prompt = '\n \n What channel would you like to see? \n \n';
channel = input(prompt);


figure;
plot(-prestim:1/data_tms_clean.fsample:poststim-1/data_tms_clean.fsample, data_tms_clean_avg1.avg(channel,:)); % Plot all data
    %xlim([0.5 2.5]); % Here we can specify the limits of what to plot on the x-axis
   % ylim([-23 15]); % Here we can specify the limits of what to plot on the y-axis
    title(['Channel ' data_tms_avg1.label{channel}]);
    ylabel('Amplitude (uV)')
    xlabel('Time (s)');
    %set(gca,'Xtick', -.5:0.1:1)
    grid on
