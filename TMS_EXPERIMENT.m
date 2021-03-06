function [ i x handles ] = TMS_EXPERIMENT( s, handles, i ,x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% This script will run the TMS EEG experiment for Dr. Near's Lab


% Set Enable
% fopen(s)
% fprintf(s,'Q@n')

% Pause
pause(1);

%pause after 80 pulses to avoid over heating
if mod(str2double(handles.TRIALS_REM),80)==0
    pause(90);
end

% Send Pulse
if x == 1 && str2double(handles.single) > 0
    % single_pulse(str2double(handles.power),s);
    display('SINGLE PULSE')
    single = str2double(handles.single) - 1;
    handles.single = num2str(single);
    display(strcat('handles.single = ' , handles.single));
    %     addline(dio,0:7,'out');
    %     data = 13;
    %     putvalue(dio.Line(1:4),data)
    
elseif x == 2
    %  lici_pulse(str2double(handles.power),s);
    display('LICI PULSE')
    lici = str2double(handles.lici) - 1;
    handles.lici = num2str(lici);
    display(strcat('handles.lici = ' , handles.lici));
    %     addline(dio,0:7,'out');
    %     data = 13;
    %     putvalue(dio.Line(1:4),data)
    
elseif  x == 3
    % icf_pulse(str2double(handles.power),s);
    display('ICF PULSE')
    icf = str2double(handles.icf) - 1;
    handles.icf = num2str(icf);
    display(strcat('handles.icf = ' , handles.icf));
    
    %     addline(dio,0:7,'out');
    %     data = 13;
    %     putvalue(dio.Line(1:4),data)
elseif  x == 4
    % custom_pulse(str2double(handles.power),str2double(handles.delay),str2double(handles.cp_percent),str2double(handles.tp_percent),s);
    display('CUSTOM PULSE')
    custom = str2double(handles.custom) - 1;
    handles.custom = num2str(custom);
    display(strcat('handles.custom = ' , handles.custom));
    
    %     addline(dio,0:7,'out');
    %     data = 13;
    %     putvalue(dio.Line(1:4),data)
    
end

% Chose next pulse
if x == 1 && str2double(handles.lici) > 0
    x = 2;
elseif x == 1 && str2double(handles.lici) == 0 && str2double(handles.icf) > 0
    x = 3;
elseif x == 1 && str2double(handles.lici) == 0 && str2double(handles.icf) == 0 && str2double(handles.custom) > 0
    x = 4;
elseif x == 1
    x = 1;
elseif x == 2 && str2double(handles.icf) > 0
    x = 3;
elseif x == 2 && str2double(handles.icf) == 0 && str2double(handles.custom) > 0
    x = 4;
elseif x == 2 && str2double(handles.icf) == 0 && str2double(handles.custom) == 0 && str2double(handles.single) > 0
    x = 1;
elseif x == 2
    x = 2;
elseif x == 3 && str2double(handles.custom) > 0
    x = 4;
elseif x == 3 && str2double(handles.custom) == 0 && str2double(handles.single) > 0
    x = 1;
elseif x == 3 && str2double(handles.custom) == 0 && str2double(handles.single) == 0 && str2double(handles.lici) > 0
    x = 2;
elseif x == 3
    x = 3;
elseif x == 4 && str2double(handles.single) > 0
    x = 1;
elseif x == 4 && str2double(handles.single) == 0 && str2double(handles.lici) > 0
    x = 2;
elseif x == 4 && str2double(handles.single) == 0 && str2double(handles.lici) == 0 && str2double(handles.icf) > 0
    x = 3;
elseif x == 4
    x = 4;
end

i = i + 1;

TRIALS_REM = str2double(handles.lici)+str2double(handles.icf)+str2double(handles.single)+str2double(handles.custom);
handles.TRIALS_REM = num2str(TRIALS_REM);

end

