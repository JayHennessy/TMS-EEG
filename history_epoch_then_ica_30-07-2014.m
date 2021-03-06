% EEGLAB history file generated on the 31-Jul-2014
% ------------------------------------------------

EEG = pop_loadbv('C:\Users\jay\Desktop\Work\EEG Tests\Second Practice test 02-07-2014\', 'Pilot2_pairedpulse_LeftM1_45.vhdr', [1 4156500], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]);
EEG.setname='raw';
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'load',{'C:\\Users\\jay\\Desktop\\Work\\Channels\\jay_good_channels.ced' 'filetype' 'autodetect'},'load',[],'delete',32);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'nochannel',{'T7' 'EMG1' 'EMG2'});
EEG = eeg_checkset( EEG );
EEG = pop_importevent( EEG, 'append','no','event','C:\\Users\\jay\\Desktop\\Work\\Programs\\event.txt','fields',{'latency' 'type'},'skipline',1,'timeunit',1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_rmdat( EEG, {'p-pulse'},[-0.0005 0.11] ,1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_epoch( EEG, {  'pulse'  }, [-1  1], 'newname', 'raw epochs', 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-1000    -5]);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_autorej(EEG, 'nogui','on','eegplot','on');
EEG = eeg_checkset( EEG );
EEG = pop_rejepoch( EEG, [1 8 14 93] ,0);
EEG = eeg_checkset( EEG );
EEG = pop_runica(EEG, 'extended',1,'interupt','on','pca',28);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
pop_eegplot( EEG, 0, 1, 1);
EEG = pop_subcomp( EEG, [1   2   4   8  12  18  19], 0);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
pop_selectcomps(EEG, [1:21] );
pop_eegplot( EEG, 0, 1, 1);
EEG = eeg_checkset( EEG );
EEG = pop_subcomp( EEG, [19], 0);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_eegfiltnew(EEG, 0.3, 60, 55000, 0, [], 1);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
