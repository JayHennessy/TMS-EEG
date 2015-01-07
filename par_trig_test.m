parport = digitalio('parallel','LPT3');
putvalue(parport, 1);
pause(3)

putvalue(parport,2);