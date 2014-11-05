function success = Rapid2_DisarmStimulator(serialPortObj)
% Rapid2_DisarmStimulator
%
% Switches the stimulator into 'offline' mode so no pulse can be triggered
% 
% - Input arguments
%   serialPortObj - MATLAB object used for communicating with a serial port. See 'help serial'
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%
% - Example:
%   success = Rapid2_DisarmStimulator(serialPortObj)
%
% - Development
%   03.10.2008, Implemented by Arman
%
% - Download page
%   http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html

% Let's start
% if there is any leftover in the communication buffer, clear it up
if serialPortObj.BytesAvailable
    out = fread(serialPortObj, serialPortObj.BytesAvailable);
    %char(out)
end

% Disarm the stimulator by sending 'EAy' command
fprintf(serialPortObj, 'EAy');

% Wait for the response from the stimulator. 
% If it takes more than a second for the stimulator to respond, ignore it
tic; elapsed = 0.0;
while ~serialPortObj.BytesAvailable && elapsed < 1
    elapsed = toc;
end

% Read the response from the stimulator if any
if serialPortObj.BytesAvailable
    out = fread(serialPortObj, serialPortObj.BytesAvailable);
    % char(out)
end

success = 1;
