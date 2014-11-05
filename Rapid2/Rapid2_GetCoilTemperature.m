function [success,  temperature] = Rapid2_GetCoilTemperature(serialPortObj)
% Rapid2_GetCoilTemperature
%
% Returns coil temperature.
% 
% - Input arguments
%   serialPortObj - MATLAB object used for communicating with a serial port. See 'help serial'
%
% - Output arguments
%   success - 1 if all ok, 0 if there is a problem
%   Temperature - structure consists of coil1 and coil2 parameters. 
%       temperature.coil1 - temperature of the first coil. -1 if cannot be acquired
%       temperature.coil2 - temperature of the second coil. -1 if cannot be acquired
%
% - Example
%   [success,  temperature] = Rapid2_GetCoilTemperature(serialPortObj)
%
% - Development
%   02.11.2008, Implemented by Arman
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

% Read the coil temperature
fprintf(serialPortObj, 'F@y');

% Wait for the response from the stimulator.
% If it takes more than a second for the stimulator to respond, ignore it
tic; elapsed = 0.0;
while ~serialPortObj.BytesAvailable && elapsed < 1
    elapsed = toc;
end

% Read the response from the stimulator if any
if serialPortObj.BytesAvailable > 0
    % in ASCII
    out = fread(serialPortObj, serialPortObj.BytesAvailable)
    %char(out)

    % convert to unsigned int
    responseInInt = int16(out);

    % when stimulator's response is the same as the command, then all ok
    % otherwise, stimulat indicates error in executing the command
    if responseInInt(1) == 70
        % get coils' temperature in tens, units and tenths
        coil1TemperatureInASCII = responseInInt(3:5);
        coil2TemperatureInASCII = responseInInt(6:8);

        % convert from ASCII to digits
        coil1TemperatureInDec = coil1TemperatureInASCII - 48;
        coil2TemperatureInDec = coil2TemperatureInASCII - 48;

        % convert to integer
        temperature.coil1 = double(coil1TemperatureInDec(1) * 100 + coil1TemperatureInDec(2) * 10 + coil1TemperatureInDec(3));
        temperature.coil2 = double(coil2TemperatureInDec(1) * 100 + coil2TemperatureInDec(2) * 10 + coil2TemperatureInDec(3));
        temperature.coil1 = temperature.coil1 / 10;
        temperature.coil2 = temperature.coil2 / 10;
        
        success = 1;
    else
        temperature.coil1 = -1;
        temperature.coil2 = -1;
    end % responseInInt(1) == 70

else
    temperature.coil1 = -1;
    temperature.coil2 = -1;
end % serialPortObj.BytesAvailable > 0
