function Rapid2_Delay(delayInMilliseconds, serialPortObj)
% Rapid2_Delay
%
% Introduces a delay without interrupting communication with the stimulator
% 
% - Input arguments
%   delayInMilliseconds - the length of delay in milliseconds
%   serialPortObj - MATLAB object used for communicating with a serial port. See 'help serial'
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%
% - Example:
%   success = Rapid2_ArmStimulator(200, serialPortObj)
%
% - Development
%   08.12.2009, Implemented by Arman
%
% - Download page
%   http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html

% Let's start
delayInSeconds = delayInMilliseconds/1000.0;
nextHundredth = 0;

tic; elapsed = 0.0;
while elapsed <= delayInSeconds
    elapsed = toc;
    % Let's maintain communication with the stimulator every 
    % 100 ms or else it will go into disarmed mode because Matlab can 
    % allocate all resources to this loop and not run the callback function
    if floor(elapsed / 0.1) > nextHundredth
        fprintf(serialPortObj, 'Q@n');
        nextHundredth = nextHundredth + 1;
    end
end
