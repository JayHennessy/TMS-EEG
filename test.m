function [ TRIALS_REM ] = test( power, icf, lici, single,status )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TRIALS_REM = icf+lici+single;
display('****   SUCCESS   ****')
end

