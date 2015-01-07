%Open Serial Communication
s = serial('COM3', 'BaudRate', 9600, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none', 'Terminator', '?');
fopen(s);

%enable communication
fprintf(s,'Q@n');
pause(0.1);

%set power
printf(s,'@050*');
pauss(0.1);

%  printf(s,delay_com)
  
%stimulate   
fprintf(s,'EHr');