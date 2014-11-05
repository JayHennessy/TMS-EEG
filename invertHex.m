function [ output ] = invertHex( input )
% Takes a hex value as input and returns its inverted equivalent.
%   eg.  FF  -->  00  or   D5  --->  2A
%
% Note the value can only be 3 digits long
%   

for i = 1:length(input)
switch input(i)
    case '0'
        output(i) = 'F';
    case '1'
        output(i) = 'E';
    case '2'
        output(i) = 'D';
    case '3'
        output(i) = 'C';
    case '4'
        output(i) = 'B';
    case '5'
        output(i) = 'A';
    case '6'
        output(i) = '9';
    case '7'
        output(i) = '8';
    case '8'
        output(i) = '7';
    case '9'
        output(i) = '6';
    case 'A'
        output(i) = '5';
    case 'B'
        output(i) = '4';
    case 'C'
        output(i) = '3';
    case 'D'
        output(i) = '2';
    case 'E'
        output(i) = '1';
    case 'F'
        output(i) = '0';
   
        
end
end
end

