% This script will run the TMS EEG experiment for Dr. Near's Lab


% User Variables
POWER_100         = 50;
TRIALS_ICF        = 120;
TRIALS_LICI       = 120;
TRIALS_SINGLE     = 120;

% Open Serial Communication
s = serial('COM1');
fopen(s)

% Open Parallel Port Communication
 daqhwinfo('parallel'); % remember to log in as administrator
parport = digitalio('parallel','LPT1');


%  run_experiment
i = 1;
x = 1;
TRIALS_TOTAL = TRIALS_ICF + TRIALS_LICI + TRIALS_SINGLE;

While i <= TRIALS_TOTAL

% Set Enable
fopen(s)
fprintf(s,'Q@n')

% Pause 
pause(4.5 + rand);

%pause after 80 pulses to avoid over heating
if mod(TRIALS_TOTAL,80)==0
    pause(90);
end
    
% Send Pulse
if x == 1 && TRIALS_LICI ~= 0
    single_pulse(POWER);
    TRIALS_SINGLE = TRIALS_SINGLE - 1;
    addline(dio,0:7,'out');
    data = 13;
    putvalue(dio.Line(1:4),data)

elseif x == 2 && TRIALS_ICF ~= 0
    lici_pulse(POWER);
    TRIALS_LICI = TRIALS_LICI - 1;
    addline(dio,0:7,'out');
    data = 13;
    putvalue(dio.Line(1:4),data)

elseif  x == 3 && TRIALS_SINGLE ~= 0
    icf_pulse(POWER);
    TRIALS_ICF = TRIALS_ICF - 1;
    addline(dio,0:7,'out');
    data = 13;
    putvalue(dio.Line(1:4),data)

end

% Chose next pulse
if x == 1 && TRIALS_LICI ~= 0
    x = 2;
elseif x == 1 && TRIALS_LICI == 0 && TRIALS_ICF ~= 0
    x = 3;
elseif x == 1
    x = 1;
end
if x == 2 && TRIALS_ICF ~= 0
    x = 3;
elseif x == 2 && TRIALS_ICF == 0 && TRIALS_SINGLE ~= 0
    x = 1;
elseif x == 2
    x = 2;
end
if x == 3 && TRIALS_SINGLE ~= 0
    x = 1;
elseif x == 3 && TRIALS_SINGLE == 0 && TRIALS_LICI ~= 0
    x = 2;
elseif x == 3
    x = 3;
end

i = i + 1;

wend

fclose(s)
delete(s)
clear s

