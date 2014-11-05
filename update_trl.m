function [ trl_new ] = update_trl( data, trl )
%UNTITLED Summary of this function goes here
% This function updates the trl variable after some of the trials have
% been removed so that it can be properly redefined a second time
%   Detailed explanation goes here

check = false;

count = 1;

if ~isfield(data.cfg,'artifact')
    artifact = data.cfg.previous.artifact;
else
    artifact = data.cfg.artifact;
end

trl_new = zeros(size(trl,1)-size(artifact,1), 2);

for i = 1:size(trl,1)
    
    for j = 1:size(artifact,1)
        if  (artifact(j,1) <= trl(i,1)+20) && (artifact(j,1) >= trl(i,1)-20) 
            check = true;
        end
    end
    
    if ~check 
        trl_new(count,1) = trl(i,1);
        trl_new(count,2) = trl(i,2);
        trl_new(count,3) = trl(i,3);
        count = count +1;
    end
    check = false;
end

end

