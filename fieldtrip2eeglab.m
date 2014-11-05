

% load data file ('dataf') preprocessed with fieldtrip
% and show in eeglab viewer

%[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;



% load chanlocs.mat
% EEG.chanlocs = chanlocs;
%EEG.chanlocs = [];
EEG.data_old =EEG.data;
EEG.data =[];
for i=1:size(data_tms_clean.trial,2)
  EEG.data(:,:,i) = single(data_tms_clean.trial{i});
end

EEG.epoch2 = EEG.epoch;
EEG.epoch = [];


for i = 1:size(data_tms_clean.trial,2)
    EEG.epoch(i).event = i;
    EEG.epoch(i).eventlatency = 0;
    EEG.epoch(i).eventtype = 'p-pulse';
%     EEG.epoch(i).eventinit_index = EEG.epoch2(i).eventinit_index;
%     EEG.epoch(i).eventinit_time = EEG.epoch2(i).eventinit_time;
%     EEG.epoch(i).eventurevent = EEG.epoch2(i).eventurevent;
    
end

EEG.setname    = 'ft_data'; %data.cfg.dataset;
% EEG.filename   = '';
% EEG.filepath   = '';
% EEG.subject    = '';
% EEG.group      = '';
% EEG.condition  = '';
EEG.session    = [];
EEG.comments   = 'preprocessed with fieldtrip';
EEG.nbchan     = size(data_tms_clean.trial{1},1);
EEG.trials     = size(data_tms_clean.trial,2);
EEG.pnts       = size(data_tms_clean.trial{1},2);
EEG.srate      = data_tms_clean.fsample;
EEG.xmin       = data_tms_clean.time{1}(1);
EEG.xmax       = data_tms_clean.time{1}(end);
EEG.times      = data_tms_clean.time{1};
% EEG.ref        = []; %'common';
% EEG.event      = [];
% EEG.epoch      = [];
% EEG.icawinv    = [];
% EEG.icasphere  = [];
% EEG.icaweights = [];
% EEG.icaact     = [];
EEG.saved      = 'no';

%   [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);


% to transform a channel location file, simply type in
% 
%  EEG.chanlocs = struct('labels', cfg.elec.label, 'X', mattocell(cfg.elec.pnt(1,:)), 'Y', mattocell(cfg.elec.pnt(2,:)),'Z', mattocell(cfg.elec.pnt(3,:)));
%  EEG.chanlocs = convertlocs(EEG.chanlocs, 'cart2all');
% 
% This code is untested. You might have to switch X, Y and Z to obtain the correct orientation for the electrode cap.
