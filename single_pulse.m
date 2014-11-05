function [  ] = single_pulse( POWER )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

POWER = POWER*1.2;

s = serial('COM1');
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

