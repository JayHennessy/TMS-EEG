function [ ] = logData( title, chanNumStart, chanNumEnd, numEpochs, numEpochsRmv, cutoff, numComp, numCompRmv, numEpochsRmv2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cd('C:\Users\jay\Desktop\Work\EEG Data');

fileID = fopen('TMS_EXP_LOG.txt','a');
fprintf(fileID,'%12s\t %4.1f\t    %4.1f\t  %4.1f\t    %4.1f\t    %4.3f\t  %4.1f\t   %4.1f\t       %4.1f\t      %12s\t\n',date, chanNumStart, chanNumEnd, numEpochs, numEpochsRmv, cutoff, numComp, numCompRmv, numEpochsRmv2 ,title);
fclose(fileID);
end

                  