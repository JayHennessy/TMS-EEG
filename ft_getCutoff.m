function [ cutOffTime cutinterval time] = ft_getCutoff( data, cfg, type )
%
% [ time ] = ft_getCutoff( data, type )
%
%   This function takes in an EEG data structure and a type (the type is an integer
%   1 if the test was single pulse and a 2 if the test in double pulse). It then 
%   outputs a time at which to cut off of the TMS pulse. Usually about 15ms
%
%

i =1;
j = 1;
k=1;
count = 1;
middle = data.fsample+(3*data.fsample/1000)-(cfg.prestim*data.fsample);
time = zeros(2,size(data.trial,2));
mincut = 0.007;

if type == 1
    while k <=size(data.label,2)
    while j < size(data.trial,2)+1
        while i <size(data.trial{1},2)/4
                           
            if abs(data.trial{j}(k,middle+i))< 150     % if less than 150, add to count
                count = count + 1;
                if count == 15              % add index (aka time) to time variable
                    count = 0;
                            
                    time(k,j) = i-15+middle;
                    break;
                    
                end                      
            elseif abs(data.trial{j}(k,middle+i))>= 150 % if greater than 150, restart count
                
                count = 0;
                
            end
           
            i = i+1;
        end
        i =1;
        j = j+1;
        
    end
     j=1;
     k = k+1;
    end
    time(time>5150)=5160;
    time(time<5015) = 5015;
    cutOffTime = round((max((time-data.fsample))/5))/1000;
    cutOffTime = mean(cutOffTime);
    if cutOffTime < mincut
        cutOffTime = mincut;
    end
    
    cutinterval = cutOffTime+(cfg.prestim);
    
    
elseif type == 2
    
    while k <=size(data.label,2)
    while j < size(data.trial,2)+1
        while i <size(data.trial{1},2)/4
            
            if abs(data.trial{j}(k,middle+i))< 150     % if less than 150, add to count
                count = count + 1;
                if count == 15              % add index (aka time) to time variable
                    time(k,j) = i-15+middle;
                    break;
                end
                
                    
            elseif (data.trial{j}(k,middle+i))>= 150 % if greater than 150, restart count
                
                count = 0;
            end
            
              i = i+1;
        end
        i =1;
        j = j+1;
    end
    j =1;
    k = k+1;
    end
    time(time>5650)=5660;
    time(time<5515) = 5515;
    
    cutOffTime = round((max((time-data.fsample))/5))/1000;
    cutOffTime = mean(cutOffTime);
    
    if cutOffTime < 0.1+mincut
        cutOffTime = 0.1+mincut;
    end
end
cutinterval = cutOffTime+(cfg.prestim);

end

