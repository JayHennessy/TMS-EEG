function [ hObject handles] = test(hObject, handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TRIALS_REM = str2double(handles.lici)+str2double(handles.icf)+str2double(handles.single);
handles.TRIALS_REM = num2str(TRIALS_REM);
display('****   SUCCESS   ****')
guidata(hObject,handles);
set(handles.text8,'String',handles.TRIALS_REM)
display('TRIAL_REM = 1')
pause(3);
set(handles.text8,'String','it worked!')
display('trial_rem =2 ')
end

