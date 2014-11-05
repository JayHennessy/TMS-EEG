function success = Rapid2_TriggerPulse(serialPortObj, mode)
% Rapid2_TriggerPulse
%
% Trigger a pulse. It takes 6-8 ms to execute this command. 
% 
% - Input arguments
%   serialPortObj - MATLAB object used for communicating a serial port. See 'help serial
%   mode - 0 means normal mode when stimulator's response will be read; 
%          1 means fast mode when stimulator's response will be ignored. 
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%
% - Example:
%   success = Rapid2_TriggerPulse(serialPortObj, 1)
%
% - Development
%   02.10.2008, Implemented by Arman
%
% - Download page
%   http://www.armanaresearch.org/rapid2matlablibrary.htm


% Let's start
% Send the command to trigger the stimulator
fprintf(serialPortObj, 'EHr');
                
if ~mode
    % Wait for the response from the stimulator.
    % If it takes more than a second for the stimulator to respond, ignore it
    tic; elapsed = 0.0;
    while ~serialPortObj.BytesAvailable && elapsed < 1
        elapsed = toc;
    end

    % Read the response from the stimulator if any
    if serialPortObj.BytesAvailable
        out = fread(serialPortObj, serialPortObj.BytesAvailable)
        % char(out)
    end

end % if

success = 1;
