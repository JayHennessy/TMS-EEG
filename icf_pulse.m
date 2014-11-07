function [  ] = icf_pulse( POWER,s )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

M_POWER = POWER*1.2;
S_POWER = POWER*0.8;


fopen(s)

% set power
   m_power_com =  getCommand('master',M_POWER);
    printf(s,m_power_com)
    
    s_power_com =  getCommand('slave',S_POWER);
    printf(s,s_power_com)
    
% set delay
    delay_com = getCommand('delay', 11);
    printf(s,delay_com)
    
% stimulate

    fprintf(s,'EJF')
    
end

