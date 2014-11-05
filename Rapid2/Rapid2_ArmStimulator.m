
function success = Rapid2_ArmStimulator(serialPortObj)
% Rapid2_ArmStimulator
%
% Put Rapid2 in 'online' mode to be able to trgger a pulse
% 
% - Input arguments
%   serialPortObj - MATLAB object to communicate with a port. See 'help serial'
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%
% - Example:
%   success = Rapid2_ArmStimulator(serialPortObj)
%
% - Development
%   02.10.2008, Implemented by Arman
%
% - Download page
%   http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html

% Let's start
success = 0;

% if there is any leftover in the communication buffer, clear it up
if serialPortObj.BytesAvailable
    out = fread(serialPortObj, serialPortObj.BytesAvailable);
    %char(out)
end

% Arm the stimulator by sending 'EBx' command
fprintf(serialPortObj, 'EBx');

% Wait for the response from the stimulator. 
% If it takes more than a second for the stimulator to respond, ignore it
tic; elapsed = 0.0;
while ~serialPortObj.BytesAvailable && elapsed < 1
    elapsed = toc;
end

% Read the response from the stimulator if any
if serialPortObj.BytesAvailable > 0
    out = fread(serialPortObj, serialPortObj.BytesAvailable);
    %char(out)
end

success = 1;
