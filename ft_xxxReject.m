function [ rejArray ] = ft_xxxReject( data,epochs,Fs )
% takes in an array with the indices of the epochs you want to reject
% and returns an array that can be input into ft_rejectartifact to reject
% those arrays

    for i = 1:size(epochs,2)
        
        rejArray(i,1) = data.sampleinfo(epochs(i),1);
        rejArray(i,2) = data.sampleinfo(epochs(i),1) + 100;       

    end
end

