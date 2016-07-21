

channel = 5;




peak160 = findpeak_new('EEG',data_tms_clean_avg1.avg, 1,channel, 60)
peak1100 = findpeak_new('EEG',data_tms_clean_avg1.avg, 1,channel, 100)

peak260 = findpeak_new('EEG',data_tms_clean_avg2.avg, 2,channel, 60)
peak2100 = findpeak_new('EEG',data_tms_clean_avg2.avg, 2,channel, 100)


peak360 = findpeak_new('EEG',data_tms_clean_avg3.avg, 3,channel, 60)
peak3100 = findpeak_new('EEG',data_tms_clean_avg3.avg, 3,channel, 100)


peak460 = findpeak_new('EEG',data_tms_clean_avg4.avg, 4,channel, 60)
peak4100 = findpeak_new('EEG',data_tms_clean_avg4.avg, 4,channel, 100)


figure
plot(data_tms_clean_avg1.time,data_tms_clean_avg1.avg(channel,:),data_tms_clean_avg2.time,data_tms_clean_avg2.avg(channel,:),data_tms_clean_avg3.time,data_tms_clean_avg3.avg(channel,:),data_tms_clean_avg4.time,data_tms_clean_avg4.avg(channel,:))
legend('1','2','3','4')
title('Single Subject Averaged Cleaned Data')
ylabel('uV')
xlabel('Time (s)')
