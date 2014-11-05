test80 = mean(EEG.data,3);
plot([0.02:0.0002:0.15], test80(5,5100:5750) )%'black',[0.02:0.0002:0.15], test100(5,5100:5750), 'green',[0.02:0.0002:0.15], test120(5,5100:5750), 'red',[0.02:0.0002:0.15], test140(5,5100:5750), 'blue')
xlabel('Time (s)')
ylabel('Voltage')
title('Black = 80, Green = 100, Red = 120, Blue = 140')