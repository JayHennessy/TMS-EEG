function [  ] = single_pulse( POWER ,s)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

POWER = POWER*1.2;


fopen(s)

% set power
   power_com =  getCommand('master',POWER);
    printf(s,power_com)
% set delay
    delay_com = getCommand('delay', 0);
    printf(s,delay_com)
% stimulate
    fprintf(s,'EJF')
    
end

