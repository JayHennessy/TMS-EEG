function [ eeg ] = eegdata( frames, epochs, srate, position)
%	eegdata simulates eeg data for 30 channels, where the 5th channel has
%	the TMS pulse artifact
%
%   frames = # of frames per epoch
%   epoch = number of trials
%   srate = sampling freq
%   position = the position of the pulse in each epoch (usually 1) 
%   

pulse = false;
%eeg = zeros(frames*epochs*30);
eeg = [];
blinkarray =  randi(100,1,10);

for i = 1:30
    if i <3
        pulse = false;
        j=1;
        while j <=(frames*epochs)-1
           
            if any(blinkarray == j)
                blinks = peak(frames,1,srate,5);
                eyes = [eyes blinks];
                j=j+1500;
            end
            j=j+1;
            eyes(j) = 0;
        end
        data = noise(frames, epochs, srate, pulse, position);
        size(data)
        size(eyes)
        data = data +(eyes.*4);
        eeg = [eeg data];
        data=[];
        eyes= [];
    elseif i == 5
        pulse = true;
        %[data freq] = randEEG(frames, epochs,srate, position,pulse);
        data = noise(frames, epochs, srate, pulse, position);
        eeg = [eeg data];
    else
        pulse = false;
        %[data freq] = randEEG(frames, epochs,srate, position,pulse);
        data = noise(frames, epochs, srate, pulse, position);
        eeg = [eeg data];
    end
        
end

    eeg  = reshape(eeg, length(eeg)/30, 30)';
end

