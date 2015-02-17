 prompt = 'Please write a comment \n';
 comment = input(prompt);
 prompt = ' Which channel do you want to analyse \n';
 channel = input(prompt);
 
%
% plot average of channel 5 across each different stimulation paradigm
S = mean(EEG_S.data,3);
P = mean(EEG_P.data,3);
I = mean(EEG_I.data,3);
C = mean(EEG_C.data,3);

plot([0:0.0002:0.2], S(5,5000:6000),'red',[0:0.0002:0.2], P(5,5500:6500),'blue',[0:0.0002:0.2], I(5,5055:6055),'green',[0:0.0002:0.2], C(5,5010:6010),'black');

% get the amount of cortical inhibition of each band
[ gamma stat_g] = ci_measure(EEG_gamma_P,EEG_gamma_S,channel,' Gamma Band');
[beta stat_b] = ci_measure(EEG_beta_P,EEG_beta_S,channel,' Beta Band');
[alpha stat_a] = ci_measure(EEG_alpha_P,EEG_alpha_S,channel, ' Alpha Band');
[theta stat_t] = ci_measure(EEG_theta_P,EEG_theta_S,channel, ' Theta Band');
[delta stat_d] = ci_measure(EEG_delta_P,EEG_delta_S,channel, ' Delta Band');
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



