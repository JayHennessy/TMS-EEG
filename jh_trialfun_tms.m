function [ artifact ] = jh_trialfun_tms( cfg )
%
%
%  [ artifact ] = jh_trialfun_tms( cfg )
%
%
% This function is used to as the cfg.trialfun for ft_artifact_tms when
% trying to mark the TMS artifact in EEG data. It should only be used after
% the data has been made into trials for each pulse.
%
% Inputs:       cfg = must contain prestim, poststim and data with trials
%                     where the pulse is 2500 time points into the trial
%
% Outputs:      artifact = a nx2 matrix where the n is the number of trials
%                           and the 2 marks the beginning and end of the
%                           part of the pulse to be cut.
%
%
%

% set the prestim and poststim in timepoints rather than seconds
prestim = cfg.prestim*cfg.data.fsample;
poststim = cfg.poststim*cfg.data.fsample;

%initialize the artifact matrix
artifact = zeros(length(cfg.data.trial),2);

% make the tms artifact matrix
for ind = 1:length(cfg.data.trial)
    
    if cfg.data.trialinfo(ind) == 1
        artifact(ind,:) = [cfg.data.sampleinfo(ind,1)+2500-prestim cfg.data.sampleinfo(ind,1)+2500+poststim];
    elseif cfg.data.trialinfo(ind) == 2
        artifact(ind,:) = [cfg.data.sampleinfo(ind,1)+2500-prestim cfg.data.sampleinfo(ind,1)+2500+poststim+0.1*cfg.data.fsample];
    elseif cfg.data.trialinfo(ind) == 3
        artifact(ind,:) = [cfg.data.sampleinfo(ind,1)+2500-prestim cfg.data.sampleinfo(ind,1)+2500+poststim+0.011*cfg.data.fsample];
    elseif cfg.data.trialinfo(ind) == 4
        artifact(ind,:) = [cfg.data.sampleinfo(ind,1)+2500-prestim cfg.data.sampleinfo(ind,1)+2500+poststim+0.001*cfg.data.fsample];
    end
    
end
artifact
end

