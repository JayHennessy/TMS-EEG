function [ eeg  ] = remove_nan_trial( eeg )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if isfield(eeg,'trial')
count =1;

for i = 0:size(eeg.trial,2)-2
    
    if isnan(eeg.trial{i+1}(1,5)) || isnan(eeg.trial{i+1}(1,size(eeg.trial{i+1},2)))
        
        cfg.artfctdef.nan.artifact(count,1) = i*size(eeg.trial{2},2)+1;
        cfg.artfctdef.nan.artifact(count,2) =  (i+1)*size(eeg.trial{2},2);
        cfg.artfctdef.reject = 'complete';
       
        count = count+1;
    end
    
end
if count ~=1
    eeg = ft_rejectartifact(cfg, eeg);
end
end

if isfield(eeg,'data')
count =1;
for i = 0:size(eeg.data,3)-1
    
    
    if isempty(find(isnan(eeg.data(:,:,i+1)),1))   
        
       eeg.data_new(:,:,count) = eeg.data(:,:,i+1);
        count = count+1;
    end
    
end
 eeg.data = eeg.data_new;
 eeg.trials = size(eeg.data,3);

end
end

