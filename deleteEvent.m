eventVector = zeros(1,size(EEG.event,2));
c =1;
for i = 1:size(EEG.event,2)
  if strcmp( EEG.event(i).type, 'boundary')
      i
      EEG.event(i) = [];
  end
end
