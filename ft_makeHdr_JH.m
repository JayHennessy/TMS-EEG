function [ hdr ] = ft_makeHdr_JH( cfg,data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
            hdr.Fs	= data.fsample;         % sampling frequency
         hdr.nChans  = length(data.label);        % number of channels
       hdr.nSamples  = 10000;           % number of samples per trial
    hdr.nSamplesPre   = 5000;           % number of pre-trigger samples in each trial
        hdr.nTrials    = length(data.trial);  
        hdr.label     = data.label;

end

