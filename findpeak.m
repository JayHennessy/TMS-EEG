function [  m_value value ] = findpeak( dataset, type )
%UNTITLED Summary of this function goes here
%   This function finds the max peak value of the EMG response
% type 1 = single, 2 = lici, 3 = icf, 4 = sici.
if type ==1
    for i =1:size(dataset,3)
        value(i) = max(abs(dataset(1,600:700,i)));
    end
    m_value = mean(value);
end

if type ==2
    for i =1:size(dataset,3)
        value(i) = max(abs(dataset(1,1125:1225,i)));
    end
    m_value = mean(value);
end

if type ==3
    for i =1:size(dataset,3)
        value(i) = max(abs(dataset(1,620:750,i)));
    end
    m_value = mean(value);
end

if type ==4
    for i =1:size(dataset,3)
        value(i) = max(abs(dataset(1,615:715,i)));
    end
    m_value = mean(value);
end
end

