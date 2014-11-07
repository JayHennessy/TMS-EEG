function [  ] = lici_pulse( POWER,s )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

M_POWER = POWER*1.2;
S_POWER = POWER*1.2;


fopen(s)

% set power
    m_power_com =  getCommand('master',M_POWER);
    printf(s,m_power_com)
    
    s_power_com =  getCommand('slave',S_POWER);
    printf(s,s_power_com)
    
% set delay
    delay_com = getCommand('delay', 100);
    printf(s,delay_com)
% stimulate
    fprintf(s,'EJF')
    
end

