function [ output] = getCommand(type, value )
% Takes a hex value as input and returns its inverted equivalent.
%   eg.  FF  -->  00  or   D5  --->  2A
%
% Note the value can only be 3 digits long
%   Detailed explanation goes here

% Master Power
if strcmp(type, 'master') ==1
    
    a = mod(value,100);
    hundreds = (value-a)/100;
    tens = (value-(hundreds*100)-mod(value,10))/10;
    ones = value-(hundreds*100)-(10*tens);
    
    x = 64 + 144 + hundreds + tens + ones;
    
    CRC = dec2hex(x);
    CRC = invertHex(CRC);
    CRC = hex2dec(CRC);
    
    CRC = char(CRC);
    
    if value<100 && value >=10
        output = strcat('@','0',int2str(value),CRC);
    elseif value<10
        output = strcat('@','00',int2str(value),CRC);
    elseif value>=100
        output = strcat('@',int2str(value),CRC);
    else
        error('value is negative');
    end
end
% Slave Power

if strcmp(type, 'slave') ==1
    
    a = mod(value,100);
    hundreds = (value-a)/100;
    tens = (value-(hundreds*100)-mod(value,10))/10;
    ones = value-(hundreds*100)-(10*tens);
    
    x = 65 + 144 + hundreds + tens + ones;
    
    CRC = dec2hex(x);
    CRC = invertHex(CRC);
    CRC = hex2dec(CRC);
    
    CRC = char(CRC);
    
    if value<100 && value >=10
        output = strcat('A','0',int2str(value),CRC);
    elseif value<10
        output = strcat('A','00',int2str(value),CRC);
    elseif value>=100
        output = strcat('A',int2str(value),CRC);
    else
        error('value is negative');
    end
end
% Delay Time

if strcmp(type, 'delay') ==1
    
    a = mod(value,100);
    hundreds = (value-a)/100;
    tens = (value-(hundreds*100)-mod(value,10))/10;
    ones = value-(hundreds*100)-(10*tens);
    
    x = 67 + 144 + hundreds + tens + ones;
    
    CRC = dec2hex(x);
    CRC = invertHex(CRC);
    CRC = hex2dec(CRC);
    
    CRC = char(CRC);
    
    if value<100 && value >=10
        output = strcat('C','0',int2str(value),CRC);
    elseif value<10
        output = strcat('C','00',int2str(value),CRC);
    elseif value>=100
        output = strcat('C',int2str(value),CRC);
    else
        error('value is negative');
    end
end



end

