function [ EMG_s1, EMG_s2, EMG_s3, EMG_s4 ] = JH_emgProcess( file_path, file_name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadbv(file_path, file_name, [], [60 61]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','EMG','gui','off'); 
EEG = eeg_checkset( EEG );

% Reref Data
EEG = pop_reref( EEG, 2);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','EMG-reref','gui','off'); 
EEG = eeg_checkset( EEG );

% check for bad data
pop_eegplot( EEG, 1, 1, 1);



% High pass filter
EEG = pop_eegfiltnew(EEG, [], 3, 8250, true, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','s10EMG-reref S1-low','gui','off'); 
EEG = eeg_checkset( EEG );

%Notch filter
EEG = pop_eegfiltnew(EEG, 59, 61, 16500, 1, [], 1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'setname','s10EMG-reref S1-low-notch','gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

% Epoch S1
EEG = pop_epoch( EEG, {  'S  1'  }, [-1  2], 'newname', 'EMG-reref S1', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'gui','off'); 
EEG = eeg_checkset( EEG );

EMG_s1 = mean(EEG.data,3);

% S2
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'retrieve',3,'study',0); 
% Epoch S2
EEG = pop_epoch( EEG, {  'S  2'  }, [-1  2], 'newname', 'EMG-reref S2', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'gui','off'); 
EEG = eeg_checkset( EEG );
 
EMG_s2= mean(EEG.data,3);

% S3
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 9,'retrieve',3,'study',0); 
% Epoch S3
EEG = pop_epoch( EEG, {  'S  3'  }, [-1  2], 'newname', 'EMG-reref S3', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 10,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 11,'gui','off'); 
EEG = eeg_checkset( EEG );
 
EMG_s3= mean(EEG.data,3);

% S4
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 12,'retrieve',3,'study',0); 
% Epoch S4
EEG = pop_epoch( EEG, {  'S  4'  }, [-1  2], 'newname', 'EMG-reref S4', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 13,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000     0]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 14,'gui','off'); 
EEG = eeg_checkset( EEG );
 
EMG_s4= mean(EEG.data,3);


end

