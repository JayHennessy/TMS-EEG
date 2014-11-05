function Rapid2_MaintainCommunication(serialPortObj, event)
% Rapid2_MaintainCommunication
%
% Maintain communication with the stimulator by sending 'Enable Remote Control'
% command. This should be used as a callback function when creating a
% serial port object. Then Matlab will automatically call upon this function 
% at specified time inervals. It is best to call this function every
% 500 ms or else the stimulator will go into standby mode and no pulse can be
% triggered until Rapid2_ArmStimulator command issued again.  
%
% - Input arguments
%   serialPortObj - MATLAB object used for communicating with a serial port. See 'help serial'
%   event - is currently unused and can be ommitted
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%
% - Example:
%   serialPortObj.TimerFcn = {'Rapid2_MaintainCommunication'};
%
% - Development
%   16.09.2008, Implemented by Arman
%
% - Download page
%   http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html


% Send'Enable Remote Control' command
fprintf(serialPortObj, 'Q@n');

% Read stimulator's response from the serial port buffer.
% If it takes more than half a second, then interrupt
% Using tic/toc here introduces problems with the main program because the current function
% is being called every 500 ms. So we use clock function to track time that
% passed waiting for a response from the stimulator
startTime = clock;
elapsed = 0; 
while ~serialPortObj.BytesAvailable && elapsed < 0.5
    currentTime = clock;
    elapsed = etime(currentTime, startTime);
end
if serialPortObj.BytesAvailable
    out = fread(serialPortObj, serialPortObj.BytesAvailable);
    % char(out)
end
