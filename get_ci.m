 prompt = ' What pulse paradigm is this data? [ S P I C] \n';
 type = input(prompt,'s');
 prompt = ' Which channel do you want to analyse \n';
 channel = input(prompt);
  prompt = ' What time interval would you like to analyse?  (ex. [50 150] ms)\n';
 interval = input(prompt);
 prompt = 'Please write a comment \n';
 comment = input(prompt,'s');
 S = mean(EEG_single.data,3);
%
% plot average of channel 5 across each different stimulation paradigm


%plot([0:0.0002:0.2], S(channel,5000:6000),'red',[0:0.0002:0.2], I(channel,5500:6500),'blue');%,[0:0.0002:0.2],  C(channel,5010:6010),'black',[0:0.0002:0.2],I(channel,5055:6055),'green');

% get the amount of cortical inhibition of each band
if strcmp(type, 'P')
    P = mean(EEG_lici.data,3);
    plot([0:0.0002:0.2], S(channel,5000:6000),'red',[0:0.0002:0.2], P(channel,5500:6500),'blue');
[ gamma stat_g] = ci_measure(EEG_gamma_P,EEG_gamma_S,channel,' Gamma Band',interval,type);
[beta stat_b] = ci_measure(EEG_beta_P,EEG_beta_S,channel,' Beta Band',interval,type);
[alpha stat_a] = ci_measure(EEG_alpha_P,EEG_alpha_S,channel, ' Alpha Band',interval,type);
[theta stat_t] = ci_measure(EEG_theta_P,EEG_theta_S,channel, ' Theta Band',interval,type);
[delta stat_d] = ci_measure(EEG_delta_P,EEG_delta_S,channel, ' Delta Band',interval,type);
elseif strcmp(type, 'I')
    I = mean(EEG_icf.data,3);

    plot([0:0.0002:0.2], S(channel,5000:6000),'red',[0:0.0002:0.2], I(channel,5055:6055),'blue');
[ gamma stat_g] = ci_measure(EEG_gamma_I,EEG_gamma_S,channel,' Gamma Band',interval,type);
[beta stat_b] = ci_measure(EEG_beta_I,EEG_beta_S,channel,' Beta Band',interval,type);
[alpha stat_a] = ci_measure(EEG_alpha_I,EEG_alpha_S,channel, ' Alpha Band',interval,type);
[theta stat_t] = ci_measure(EEG_theta_I,EEG_theta_S,channel, ' Theta Band',interval,type);
[delta stat_d] = ci_measure(EEG_delta_I,EEG_delta_S,channel, ' Delta Band',interval,type);
elseif strcmp(type, 'C')
    C = mean(EEG_custom.data,3);

    plot([0:0.0002:0.2], S(channel,5000:6000),'red',[0:0.0002:0.2], C(channel,5010:6010),'blue');
[ gamma stat_g] = ci_measure(EEG_gamma_C,EEG_gamma_S,channel,' Gamma Band',interval,type);
[beta stat_b] = ci_measure(EEG_beta_C,EEG_beta_S,channel,' Beta Band',interval,type);
[alpha stat_a] = ci_measure(EEG_alpha_C,EEG_alpha_S,channel, ' Alpha Band',interval,type);
[theta stat_t] = ci_measure(EEG_theta_C,EEG_theta_S,channel, ' Theta Band',interval,type);
[delta stat_d] = ci_measure(EEG_delta_C,EEG_delta_S,channel, ' Delta Band',interval,type);
end

date = date;
ci = [ delta theta alpha beta gamma];

%plot([0:0.0002:0.3], p(5, [5000:6500]), 'blue', [0:0.0002:0.3], s(5, [5500:7000]), 'red');

%
%document the inhibition in a table
cd('C:\Users\jay\Desktop\Work\EEG Data');

fileID = fopen('CI_TABLE.txt','a');
%fprintf(fileID,'%6s\t\t %12s\t %6s\r\n',' date  ','GAMMA | BETA | ALPHA | THETA | DELTA', '   Comment');
fprintf(fileID,'%12s\t %4.1f\t %4.1f\t %4.1f\t %4.1f\t %4.1f\t %12s\r\n',date, ci, comment);
fclose(fileID);



