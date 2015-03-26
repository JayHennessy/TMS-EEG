 prompt = ' Is this single, paired, icf or custom data? \n';
 pulse = input(prompt,'s')
 prompt = ' What folder do you want to save to in the EEG_data folder? (usually a study folder) \n';
 folder_name = input(prompt,'s')
 folder_name = strcat('C:\Users\jay\Desktop\Work\EEG data\',folder_name);
 prompt = ' What do you want to call the file they are saved to? \n';
 savefile = input(prompt,'s')
if strcmp('paired', pulse)
    EEG_lici.etc = [];
    EEG_temp = pop_select( EEG_lici,'channel',{'C3' 'F3'});
    EEG_delta_P = pop_firws(EEG_temp, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_delta_P, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_P = pop_firws(EEG_temp, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
    %figure; pop_plottopo(EEG_theta_P, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_P = pop_firws(EEG_temp, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder',1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_alpha_P, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_P = pop_firws(EEG_temp, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_P, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_P = pop_firws(EEG_temp, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_gamma_P, 5, 'Gamma Band', 0, 'ydir',1);
    
 
    %save each dataset
  
    cd(folder_name);
    save(strcat(savefile,'.mat'), 'EEG_delta_P', 'EEG_theta_P', 'EEG_alpha_P', 'EEG_beta_P', 'EEG_gamma_P', 'EEG_lici');
    
   % EEG_lici = pop_saveset(EEG_lici, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
elseif strcmp('single', pulse)
    EEG_single.etc = [];
    EEG_temp = pop_select( EEG_single, 'channel' , {'C3' 'F3' });
    EEG_delta_S = pop_firws(EEG_temp, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
%    figure; pop_plottopo(EEG_delta_S, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_S = pop_firws(EEG_temp, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_theta_S, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_S = pop_firws(EEG_temp, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_alpha_S, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_S = pop_firws(EEG_temp, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_S, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_S = pop_firws(EEG_temp, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_gamma_S, 5, 'Gamma Band', 0, 'ydir',1);
    
   
    %save each dataset
    cd(folder_name);
    save(strcat(savefile,'.mat'), 'EEG_delta_S', 'EEG_theta_S', 'EEG_alpha_S', 'EEG_beta_S', 'EEG_gamma_S', 'EEG_single');
  %  EEG_single = pop_saveset(EEG_single, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
elseif strcmp('icf', pulse)
    
    EEG_icf.etc = [];
        EEG_temp = pop_select( EEG_icf,'channel',{'C3' 'F3' });

    EEG_delta_I = pop_firws(EEG_temp, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
%    figure; pop_plottopo(EEG_delta_S, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_I = pop_firws(EEG_temp, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_theta_S, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_I = pop_firws(EEG_temp, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_alpha_S, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_I = pop_firws(EEG_temp, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_S, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_I = pop_firws(EEG_temp, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_gamma_S, 5, 'Gamma Band', 0, 'ydir',1);
    
    
    %save each dataset
     cd(folder_name);
    save(strcat(savefile,'.mat'), 'EEG_delta_I', 'EEG_theta_I', 'EEG_alpha_I', 'EEG_beta_I', 'EEG_gamma_I', 'EEG_icf');
 %   EEG_icf = pop_saveset(EEG_icf, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
elseif strcmp('custom', pulse) 
    
    EEG_custom.etc = [];
    EEG_temp = pop_select( EEG_custom,'channel',{'C3' 'F3' });

    
    EEG_delta_C = pop_firws(EEG_temp, 'fcutoff', [1 3.5], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
%    figure; pop_plottopo(EEG_delta_S, 5, 'Delta band', 0, 'ydir',1);
    
    EEG_theta_C = pop_firws(EEG_temp, 'fcutoff', [4 7], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
   % figure; pop_plottopo(EEG_theta_S, 5, 'Theta band', 0, 'ydir',1);
    
    EEG_alpha_C = pop_firws(EEG_temp, 'fcutoff', [8 12], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_alpha_S, 5, 'Alpha Band', 0, 'ydir',1);
    
    EEG_beta_C = pop_firws(EEG_temp, 'fcutoff', [12.5 28], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_beta_S, 5, 'Beta Band', 0, 'ydir',1);
    
    EEG_gamma_C = pop_firws(EEG_temp, 'fcutoff', [30 50], 'ftype', 'bandpass', 'wtype', 'hamming', 'forder', 1000, 'minphase', 0);
  %  figure; pop_plottopo(EEG_gamma_S, 5, 'Gamma Band', 0, 'ydir',1);
    
  
    %save each dataset
     cd(folder_name);
    save(strcat(savefile,'.mat'), 'EEG_delta_C', 'EEG_theta_C', 'EEG_alpha_C', 'EEG_beta_C', 'EEG_gamma_C', 'EEG_custom');
 %   EEG_custom = pop_saveset(EEG_custom, 'filepath', 'C:\Users\jay\Desktop\Work\EEG data');
else

    
    error(' Incorrect type of data, please try again');
end