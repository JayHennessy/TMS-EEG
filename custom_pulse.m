function [  ] = custom_pulse( POWER, DELAY, CP, TP, s )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

M_POWER = POWER*CP/100;
S_POWER = POWER*TP/100;


fopen(s)

% set power
   m_power_com =  getCommand('master',M_POWER);
    fprintf(s,m_power_com)
    
    s_power_com =  getCommand('slave',S_POWER);
    fprintf(s,s_power_com)
    
% set delay
    delay_com = getCommand('delay', DELAY);
    fprintf(s,delay_com)
    
% stimulate

    fprintf(s,'EJF')
end

