 prompt = ' Is this single or paired data? \n';
 pulse = input(prompt) 
 prompt = ' What do you want to call the file they are saved to? \n';
 savefile = input(prompt)
if strcmp('paired', pulse) ==1
    EEG_delta_P = pop_firws(EEG, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_delta_P, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_P = pop_firws(EEG, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
    %figure; pop_plottopo(EEG_theta_P, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_P = pop_firws(EEG, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder',1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_alpha_P, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_P = pop_firws(EEG, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_P, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_P = pop_firws(EEG, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_gamma_P, 5, 'Gamma Band', 0, 'ydir',1);
    
    EEG_P = EEG;
    %save each dataset
    cd('C:\Users\jay\Desktop\Work\EEG data');
    save(strcat(savefile,'.mat'), 'EEG_delta_P', 'EEG_theta_P', 'EEG_alpha_P', 'EEG_beta_P', 'EEG_gamma_P', 'EEG_P');
    
    EEG = pop_saveset(EEG, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
end

if strcmp('single', pulse) ==1
    
    EEG_delta_S = pop_firws(EEG, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
%    figure; pop_plottopo(EEG_delta_S, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_S = pop_firws(EEG, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_theta_S, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_S = pop_firws(EEG, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_alpha_S, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_S = pop_firws(EEG, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_S, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_S = pop_firws(EEG, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_gamma_S, 5, 'Gamma Band', 0, 'ydir',1);
    
    EEG_S = EEG;
    %save each dataset
    cd('C:\Users\jay\Desktop\Work\EEG data');
    save(strcat(savefile,'.mat'), 'EEG_delta_S', 'EEG_theta_S', 'EEG_alpha_S', 'EEG_beta_S', 'EEG_gamma_S', 'EEG_S');
    EEG = pop_saveset(EEG, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
end