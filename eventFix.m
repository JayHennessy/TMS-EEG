for i = 1:size(EEG.event,2)
   if strcmp(EEG.event(i).type, 'boundary')
   EEG.event(i).urevent = i;
   EEG.event(i).type = 'p-pulse';
   end
end