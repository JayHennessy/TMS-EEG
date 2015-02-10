

% load data file ('dataf') preprocessed with fieldtrip
% and show in eeglab viewer

%[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

switch do_ica
    case 1

% load chanlocs.mat
% EEG.chanlocs = chanlocs;
%EEG.chanlocs = [];
EEG_single.data_old =EEG.data;
EEG_single.data =[];
for i=1:size(data_tms_clean.trial,2)
  EEG_single.data(:,:,i) = single(data_tms_clean.trial{i});
end

EEG_single.epoch2 = EEG.epoch;
EEG_single.epoch = [];


for i = 1:size(data_tms_clean.trial,2)
    EEG_single.epoch(i).event = i;
    EEG_single.epoch(i).eventlatency = 0;
    EEG_single.epoch(i).eventtype = 'S1';
%     EEG.epoch(i).eventinit_index = EEG.epoch2(i).eventinit_index;
%     EEG.epoch(i).eventinit_time = EEG.epoch2(i).eventinit_time;
%     EEG.epoch(i).eventurevent = EEG.epoch2(i).eventurevent;
    
end

EEG_single.setname    = 'ft_data'; %data.cfg.dataset;
% EEG.filename   = '';
% EEG.filepath   = '';
% EEG.subject    = '';
% EEG.group      = '';
% EEG.condition  = '';
EEG_single.session    = [];
EEG_single.comments   = 'preprocessed with fieldtrip';
EEG_single.nbchan     = size(data_tms_clean.trial{1},1);
EEG_single.trials     = size(data_tms_clean.trial,2);
EEG_single.pnts       = size(data_tms_clean.trial{1},2);
EEG_single.srate      = data_tms_clean.fsample;
EEG_single.xmin       = data_tms_clean.time{1}(1);
EEG_single.xmax       = data_tms_clean.time{1}(end);
EEG_single.times      = data_tms_clean.time{1};
% EEG.ref        = []; %'common';
% EEG.event      = [];
% EEG.epoch      = [];
% EEG.icawinv    = [];
% EEG.icasphere  = [];
% EEG.icaweights = [];
% EEG.icaact     = [];
EEG_single.saved      = 'no';

%   [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);


% to transform a channel location file, simply type in
% 
%  EEG.chanlocs = struct('labels', cfg.elec.label, 'X', mattocell(cfg.elec.pnt(1,:)), 'Y', mattocell(cfg.elec.pnt(2,:)),'Z', mattocell(cfg.elec.pnt(3,:)));
%  EEG.chanlocs = convertlocs(EEG.chanlocs, 'cart2all');
% 
% This code is untested. You might have to switch X, Y and Z to obtain the correct orientation for the electrode cap.

    case 2
        
        EEG_lici.data_old =EEG.data;
EEG_lici.data =[];
for i=1:size(data_tms_clean.trial,2)
  EEG_lici.data(:,:,i) = single(data_tms_clean.trial{i});
end

EEG_lici.epoch2 = EEG.epoch;
EEG_lici.epoch = [];


for i = 1:size(data_tms_clean.trial,2)
    EEG_lici.epoch(i).event = i;
    EEG_lici.epoch(i).eventlatency = 0;
    EEG_lici.epoch(i).eventtype = 'S1';
%     EEG.epoch(i).eventinit_index = EEG.epoch2(i).eventinit_index;
%     EEG.epoch(i).eventinit_time = EEG.epoch2(i).eventinit_time;
%     EEG.epoch(i).eventurevent = EEG.epoch2(i).eventurevent;
    
end

EEG_lici.setname    = 'ft_data'; %data.cfg.dataset;
% EEG.filename   = '';
% EEG.filepath   = '';
% EEG.subject    = '';
% EEG.group      = '';
% EEG.condition  = '';
EEG_lici.session    = [];
EEG_lici.comments   = 'preprocessed with fieldtrip';
EEG_lici.nbchan     = size(data_tms_clean.trial{1},1);
EEG_lici.trials     = size(data_tms_clean.trial,2);
EEG_lici.pnts       = size(data_tms_clean.trial{1},2);
EEG_lici.srate      = data_tms_clean.fsample;
EEG_lici.xmin       = data_tms_clean.time{1}(1);
EEG_lici.xmax       = data_tms_clean.time{1}(end);
EEG_lici.times      = data_tms_clean.time{1};
% EEG_lici.ref        = []; %'common';
% EEG_lici.event      = [];
% EEG_lici.epoch      = [];
% EEG_lici.icawinv    = [];
% EEG_lici.icasphere  = [];
% EEG_lici.icaweights = [];
% EEG_lici.icaact     = [];
EEG_lici.saved      = 'no';

    case 3
        
        EEG_icf.data_old =EEG.data;
EEG_icf.data =[];
for i=1:size(data_tms_clean.trial,2)
  EEG_icf.data(:,:,i) = single(data_tms_clean.trial{i});
end

EEG_icf.epoch2 = EEG.epoch;
EEG_icf.epoch = [];


for i = 1:size(data_tms_clean.trial,2)
    EEG_icf.epoch(i).event = i;
    EEG_icf.epoch(i).eventlatency = 0;
    EEG_icf.epoch(i).eventtype = 'S1';
%     EEG_icf.epoch(i).eventinit_index = EEG_icf.epoch2(i).eventinit_index;
%     EEG_icf.epoch(i).eventinit_time = EEG_icf.epoch2(i).eventinit_time;
%     EEG_icf.epoch(i).eventurevent = EEG_icf.epoch2(i).eventurevent;
    
end

EEG_icf.setname    = 'ft_data'; %data.cfg.dataset;
% EEG_icf.filename   = '';
% EEG_icf.filepath   = '';
% EEG_icf.subject    = '';
% EEG_icf.group      = '';
% EEG_icf.condition  = '';
EEG_icf.session    = [];
EEG_icf.comments   = 'preprocessed with fieldtrip';
EEG_icf.nbchan     = size(data_tms_clean.trial{1},1);
EEG_icf.trials     = size(data_tms_clean.trial,2);
EEG_icf.pnts       = size(data_tms_clean.trial{1},2);
EEG_icf.srate      = data_tms_clean.fsample;
EEG_icf.xmin       = data_tms_clean.time{1}(1);
EEG_icf.xmax       = data_tms_clean.time{1}(end);
EEG_icf.times      = data_tms_clean.time{1};
% EEG_icf.ref        = []; %'common';
% EEG_icf.event      = [];
% EEG_icf.epoch      = [];
% EEG_icf.icawinv    = [];
% EEG_icf.icasphere  = [];
% EEG_icf.icaweights = [];
% EEG_icf.icaact     = [];
EEG_icf.saved      = 'no';

    case 4
        
        EEG_custom.data_old =EEG.data;
EEG_custom.data =[];
for i=1:size(data_tms_clean.trial,2)
  EEG_custom.data(:,:,i) = single(data_tms_clean.trial{i});
end

EEG_custom.epoch2 = EEG.epoch;
EEG_custom.epoch = [];


for i = 1:size(data_tms_clean.trial,2)
    EEG_custom.epoch(i).event = i;
    EEG_custom.epoch(i).eventlatency = 0;
    EEG_custom.epoch(i).eventtype = 'S1';
%     EEG_custom.epoch(i).eventinit_index = EEG_custom.epoch2(i).eventinit_index;
%     EEG_custom.epoch(i).eventinit_time = EEG_custom.epoch2(i).eventinit_time;
%     EEG_custom.epoch(i).eventurevent = EEG_custom.epoch2(i).eventurevent;
    
end

EEG_custom.setname    = 'ft_data'; %data.cfg.dataset;
% EEG_custom.filename   = '';
% EEG_custom.filepath   = '';
% EEG_custom.subject    = '';
% EEG_custom.group      = '';
% EEG_custom.condition  = '';
EEG_custom.session    = [];
EEG_custom.comments   = 'preprocessed with fieldtrip';
EEG_custom.nbchan     = size(data_tms_clean.trial{1},1);
EEG_custom.trials     = size(data_tms_clean.trial,2);
EEG_custom.pnts       = size(data_tms_clean.trial{1},2);
EEG_custom.srate      = data_tms_clean.fsample;
EEG_custom.xmin       = data_tms_clean.time{1}(1);
EEG_custom.xmax       = data_tms_clean.time{1}(end);
EEG_custom.times      = data_tms_clean.time{1};
% EEG_custom.ref        = []; %'common';
% EEG_custom.event      = [];
% EEG_custom.epoch      = [];
% EEG_custom.icawinv    = [];
% EEG_custom.icasphere  = [];
% EEG_custom.icaweights = [];
% EEG_custom.icaact     = [];
EEG_custom.saved      = 'no';

end
