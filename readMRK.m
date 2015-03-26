function [ type location ] = readMRK( filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% 
% This function takes in a filename and outputs an array containing the
% types of markers contained in the marker file of an EEG dataset.

fid = fopen(filename);
temp = cell(1);
temp{1} = fgetl(fid);

% find the beginning of the marker recording data
while ~strcmp(temp{1}(1:3),'Mk1')
    temp{1} = fgetl(fid);
    if isempty(temp{1})
        temp{1} = 'new line';
    end
end


% Record all the markers
i = 1;
mrk{1} = fgetl(fid);
while ~feof(fid)    
    i = i+1;
    mrk{i} = fgetl(fid);
    
end

% locate the position of the comma's that delimit the different marker data
comma = strfind(mrk,',');


% Find the actual type of marker and its location
j=1;
c=1;
while j<=size(comma,2)
    if strcmp(mrk{j}(comma{j}(1)+1),'S')
        type(c) = str2double(mrk{j}(comma{j}(1)+4));
        location(c) = str2double(mrk{j}(comma{j}(2)+1:comma{j}(3)-1));
        c=c+1;
    end
    j = j+1;
    
end

type = type';
location = location';

fclose(fid);
end
