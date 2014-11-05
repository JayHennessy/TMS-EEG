
%     JH_findEvent finds the time that each TMS pulse occurs and marks
%     it as an event in EEGLAB dataset. It also makes a file called event that
%     stores the location of each event. (it only finds about 75% of the pulses
%     and it only works for paired pulses)
% 
%       Then it processes the data



eeglab

prompt = '\n Do you need to simulate data? (y/n) \n ';
sim = input(prompt);


% chose the eeg file
if isequal(sim, 'n')

filename = uigetfile
%   [ Giovanni test 03-06-2014 ]  or  [ Second Practice test 02-07-2014 ]
EEG = pop_loadbv('C:\Users\jay\Desktop\Work\EEG Tests\Second Practice test 02-07-2014\', filename);
prompt = '\n Is this data paired pulse or single pulse? (''paired'' or ''single'') \n ';
pulse = input(prompt);
end

%simulate the data
if isequal(sim, 'y')
simData = eegdata(1500,100,1000,1);
EEG = pop_importdata('dataformat','array','nbchan',30,'data','simData','srate',1000,'pnts',0,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','simulated data','gui','off'); 
EEG = eeg_checkset( EEG );
end

prompt = '\n Is this data paired pulse or single pulse? (''paired'' or ''single'') \n ';
pulse = input(prompt);
prompt2 = '\n What will be the name of the file you save the variables to? \n ';
savefile = input(prompt2);

count = 1;
event_channel = [];
event_pos = [];

%if there are more than 30 channels then 31 and 32 are EMG so remove them
if EEG.nbchan>30
EEG = pop_select( EEG,'nochannel',[ 31 32]);
end

EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\jay\\Desktop\\Work\\Channels\\jay_good_channels.ced' 'filetype' 'autodetect'});


%resample the data from to 1000 Hz
EEG = pop_resample( EEG, 1000);

%find events and save the time that they occur to event_pos
if strcmp('single', pulse) ==1
    i=1;
    while i <= size(EEG.data,2)
        event_channel(i) = 0;
        if (EEG.data(5,i)<-2000) %&& ( -2000<EEG.data(5,i+50)<2000) %&& ( EEG.data(5,i-15)>-9000) %&& (EEG.data(5,i+100)<-13000)
            event_channel(i) = 1;
            event_channel(i+1:i+4) = 0;
            event_pos(count) = i -11;
            count = count + 1;
            i = i+200;
        end
        i = i+1;
    end
end
if strcmp('paired', pulse) ==1
    i=1;
    while i <= size(EEG.data,2)
        event_channel(i) = 0;
        if (EEG.data(5,i)< -2000)% && ( -2000<EEG.data(5,i+50)<2000) && ( EEG.data(5,i-15)>-9000) 
            event_channel(i) = 1;
            event_channel(i+1:i+4) = 0;
            event_pos(count) = i -11;
            count = count + 1;
            i = i+99;
        end
        i = i+1;
    end
end

    

%make the event txt file
cd('C:\Users\jay\Desktop\Work\Programs');
fid = fopen('event.txt', 'wt');
fprintf(fid, 'latency type\n');
for i = 1:length(event_pos)
fprintf(fid, '%d   p-pulse\n', event_pos(i));

end

fclose(fid);


%load the events to the EEG data
EEG = pop_importevent( EEG, 'append','no','event','C:\Users\jay\Desktop\Work\Programs\event.txt','fields',{'latency' 'type'},'skipline',1,'timeunit',NaN);
EEG = eeg_checkset( EEG );
%pop_eegplot( EEG, 1, 1, 1);

%reject the TMS artifact at each stimulus
if strcmp('paired', pulse) ==1
    EEG = pop_rmdat( EEG, {'p-pulse'},[0 0.107] ,1);
end
if strcmp('single', pulse) ==1
    EEG = pop_rmdat( EEG, {'p-pulse'},[0 0.107] ,1);
end

%epoch the data into 1 second chunks
EEG = pop_epoch( EEG, {  'boundary'  }, [-1 1], 'newname', 'raw resampled - rejected epochs', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-1  0]);

% filter the data between 1-100Hz and 60hz notch filter
EEG = pop_eegfiltnew(EEG, 0.3, 200, 3300, 0, [], 0);
%EEG = pop_firpm(EEG, 'fcutoff', [60 61], 'ftrans', 0.5, 'ftype', 'bandstop', 'wtpass', 1, 'wtstop', 1.14623, 'forder', 1348);


% now we auto reject epochs with a 1000uV threshold, probability threshold
% of 5 (std. dev) and a maximum of 10% of the epochs can be removed
[EEG rmepochs] = pop_autorej(EEG, 'nogui','on','eegplot','on','maxrej',10 );

%make array to indicate what trials to remove
rejarray = zeros(1,EEG.trials);
for i = 1:size(rmepochs,2)
    rejarray(rmepochs(i)) = 1;
end


EEG = pop_rejepoch( EEG, rejarray,0);

% here we need to reject bad epochs by eye
%pop_eegplot( EEG, 1, 1, 1);

[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    
prompt = 'Are you done removing artifacts by eye? (y = yes, n = no) \n ';
result = input(prompt);


% once it is rejected by eye, we can run ICA
if isequal(result, 'y')

    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
   
    % reject 10% of epochs based on thresholding ICA
    thresh = 10;
    [EEG indexes]= pop_eegthresh(EEG,0,[1:size(EEG.icaact,1)] ,-thresh,thresh,0.001,0.999,0,0);
    
    % find 10% of removable eopchs
    while size(indexes,2)> EEG.trials/10
    EEG.reject.icarejthreshE = zeros(size(EEG.reject.icarejthreshE));
    EEG.reject.icarejthresh = zeros(size(EEG.reject.icarejthresh));
    [EEG indexes]= pop_eegthresh(EEG,0,[1:size(EEG.icaact,1)] ,-thresh,thresh,0.001,0.999,0,0);
    thresh = thresh+3;
    end
    
     %make array to indicate what trials to remove
     rejarray2 = zeros(1,EEG.trials);
    
     for i = 1:size(indexes,2)
     rejarray2(indexes(i)) = 1;
     end
     EEG = pop_rejepoch(EEG, rejarray2 , 0);
     
    % reject epochs based on spectrum 
    EEG = pop_rejspec( EEG, 0,'elecrange',[1:size(EEG.icaact,1)],'threshold',[-47 47] ,'freqlimits',[0 55] ,'eegplotplotallrej',2,'eegplotreject',1);

%now inspect the components in the 2-D component map and reject muscle and
%eye artifact by eye

    pop_selectcomps(EEG, [1:size(EEG.icaact,1)]);    
    
    prompt = 'Are you done removing components by eye? (y = yes, n = no) \n';
    result = input(prompt)
    EEG = pop_subcomp( EEG, [], 0);
 
    if isequal(result, 'y')
        
        %now we have to get each band seperated using the hamming filter
        %and plot it using the topographic map. Here we are graphing
        %channel 5 (C3/M1)
        
        if strcmp('paired', pulse) ==1
            EEG_delta_P = pop_firws(EEG, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_delta_P, 5, 'Delta band', 0, 'ydir',1);
            
            EEG_theta_P = pop_firws(EEG, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_theta_P, 5, 'Theta band', 0, 'ydir',1);
            
            EEG_alpha_P = pop_firws(EEG, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder',1000, 'minphase', 0);
            figure; pop_plottopo(EEG_alpha_P, 5, 'Alpha Band', 0, 'ydir',1);
            
            EEG_beta_P = pop_firws(EEG, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_beta_P, 5, 'Beta Band', 0, 'ydir',1);
            
            EEG_gamma_P = pop_firws(EEG, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_gamma_P, 5, 'Gamma Band', 0, 'ydir',1);
            
            %save each dataset
            cd('C:\Users\jay\Desktop\Work\EEG data');
            save(strcat(savefile,'.mat'), 'EEG_delta_P', 'EEG_theta_P', 'EEG_alpha_P', 'EEG_beta_P', 'EEG_gamma_P');

            EEG = pop_saveset(EEG, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
        end
        
        if strcmp('single', pulse) ==1
            
            EEG_delta_S = pop_firws(EEG, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_delta_S, 5, 'Delta band', 0, 'ydir',1);
            
            EEG_theta_S = pop_firws(EEG, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_theta_S, 5, 'Theta band', 0, 'ydir',1);
            
            EEG_alpha_S = pop_firws(EEG, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_alpha_S, 5, 'Alpha Band', 0, 'ydir',1);
            
            EEG_beta_S = pop_firws(EEG, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_beta_S, 5, 'Beta Band', 0, 'ydir',1);
            
            EEG_gamma_S = pop_firws(EEG, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
            figure; pop_plottopo(EEG_gamma_S, 5, 'Gamma Band', 0, 'ydir',1);
            
            %save each dataset
            cd('C:\Users\jay\Desktop\Work\EEG data');
            save(strcat(savefile,'.mat'), 'EEG_delta_S', 'EEG_theta_S', 'EEG_alpha_S', 'EEG_beta_S', 'EEG_gamma_S');
            EEG = pop_saveset(EEG, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
        end

    end
    
   
end
