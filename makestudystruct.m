for n=1:9 
    N{n}=['00' num2str(n)];
end
for n=10:99
    N{n}=['0' num2str(n)];
end
for n=100:129
    N{n}=[num2str(n)];
end


% %%%%%%%%%%THE CODE BELOW WILL WORK FOR N10_03%%%%%%%%%%%%%%%%%%%%
% for n=1
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=2
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=3:5
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=6
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=7
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=9:12
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=13
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=14:24
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=25:27
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=28:29
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=30
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo2/lcm-out/pressHippo2_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=31:48
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=49
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=50:62
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=63
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=64:66
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=67
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=68:70
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=71
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=72:81
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=82
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=83:89
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=90
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=91:94
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=95
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     N{n}
%     %out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_total_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     %disp(['finished N10_28_' N{n}]);   eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=96:103
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=104
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=105:117
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=118:119
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% for n=120:129
%     out=readlcmtab(['~/scratch/N10_03/N10_03_' N{n} '/pressHippo/lcm-out/pressHippo_DriftCorr2.table']);
%     eval(['studystruct.N10_03_' N{n} '=out;']);
% end
% 
% %%%%%%%%%%%%%END OF N10_03%%%%%%%%%%%%%%%%



%%%%%%%%%%%THE CODE BELOW WILL WORK FOR N10_27%%%%%%%%%%%%%%%%%%%%%%%%
% for n=2:3
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=5:7
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=8
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=9:14
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=15:17
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=18:20
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=22:28
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=30
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end
% 
% for n=31:37
%     N{n}
%     out=readlcmtab(['~/scratch/N10_27/N10_27_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N10_27_' N{n} '=out;']);
%     disp(['finished N10_27_' N{n}]);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

%%%%%%%%%%THE CODE BELOW WILL WORK FOR N10_28%%%%%%%%%%%%%%%%%%%%%%%%
% for n=1:13
%     N{n}
%     out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_total_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     disp(['finished N10_28_' N{n}]);
% end
% 
% for n=14:15
%     N{n}
%     out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     disp(['finished N10_28_' N{n}]);
% end
% 
% for n=16:31
%     N{n}
%     out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_total_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     disp(['finished N10_28_' N{n}]);
% end

% for n=21:22
%     N{n}
%     out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     disp(['finished N10_28_' N{n}]);
% end
% 
% for n=23:31
%     N{n}
%     out=readlcmtab(['~/scratch/N10_28/N10_28_' N{n} '/special/lcm-out/special_total_nows.table']);
%     eval(['studystruct.N10_28_' N{n} '=out;']);
%     disp(['finished N10_28_' N{n}]);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% % %%%%%%%THIS CODE FOR N10_01 %%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/NT07362/special_front.table']);
% % studystruct.NT07362=out;
% % disp(['finished NT07362']);
% % 
% % out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/NT07416/special_front.table']);
% % studystruct.NT07416=out;
% % disp(['finished NT07416']);
% % 
% % out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/NT07462/special_front.table']);
% % studystruct.NT07462=out;
% % disp(['finished NT07462']);
% % 
% % out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/NT07475/special_front.table']);
% % studystruct.NT07475=out;
% % disp(['finished NT07475']);
% % 
% % for n=[1:4 6:9]
% %     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_00' num2str(n) '/special_front.table']);
% %     eval(['studystruct.N10_01_00' num2str(n) '=out;']);
% %     disp(['finished N10_01_00' num2str(n) ]);
% % end
% % 
% % for n=10:11
% %     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front.table']);
% %     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
% %     disp(['finished N10_01_0' num2str(n) ]);
% % end
% % 
% % for n=12
% %     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
% %     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
% %     disp(['finished N10_01_0' num2str(n) ]);
% % end
% % 
% % for n=13
% %     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front.table']);
% %     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
% %     disp(['finished N10_01_0' num2str(n) ]);
% % end
% % 
% % for n=14:19
% %     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
% %     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% for n=20
%     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% for n=22:29
%     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% for n=31:34
%     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% for n=36:39
%     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% % for n=39
% %     out=readlcmtab(['~/scratch/N10_01/N10_01_0' num2str(n) '/special_rear/lcm-out/special_front_DriftCorr2.table']);
% %     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
% %     disp(['finished N10_01_0' num2str(n) ]);
% % end
% 
% for n=40:42
%     out=readlcmtab(['~taylor/scratch/ifn1/lcmodel/N10_01_0' num2str(n) '/special_front_dc.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
% for n=[43:45 47:50]
%     out=readlcmtab(['~/scratch/N10_01/N10_01_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
%     eval(['studystruct.N10_01_0' num2str(n) '=out;']);
%     disp(['finished N10_01_0' num2str(n) ]);
% end
% 
%%%%%%%%%%%%%%%%%END OF CODE FOR N10_01%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% %%%%%%%%%%%%%THE FOLLOWING CODE WILL WORK FOR N11_13  FRONT (subjects 1-39)%%%%%%%%%%%%%%%%%%%%
% 
% for n=2:9
% out=readlcmtab(['~/scratch/N11_13/subs1_20/N11_13_00' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_00' num2str(n) '=out;']);
% disp(['finished N11_13_00' num2str(n)]);
% end
% 
% for n=10:20
% out=readlcmtab(['~/scratch/N11_13/subs1_20/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% disp(['finished N11_13_0' num2str(n)]);
% end
% 
% % out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_021' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% % eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% % disp(['finished N11_13_0' num2str(n)]);
% 
% for n=21:22
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% disp(['finished N11_13_0' num2str(n)]);
% end
% 
% for n=25:26
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% disp(['finished N11_13_0' num2str(n)]);
% end
% 
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_027/special_front2/lcm-out/special_front2_DriftCorr2.table']);
% eval(['studystruct.N11_13_027=out;']);
% disp(['finished N11_13_027']);
% 
% for n=28:29
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% disp(['finished N11_13_0' num2str(n)]);
% end
% 
% for n=31:39
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
% eval(['studystruct.N11_13_0' num2str(n) '=out;']);
% disp(['finished N11_13_0' num2str(n)]);
% end
% 
% 
% 
% %%%%%%%%%%%%


% %%%%%%THE FOLLOWING WILL WORK FOR N11_13_REAR  (subjects 1-39) %%%%%%%%%%%%%%%%%
% for n=[3 5:6 8:9]
%     out=readlcmtab(['~/scratch/N11_13/subs1_20/N11_13_00' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_00' num2str(n) '=out;']);
%     disp(['finished N11_13_00' num2str(n)]);
% end
% 
% for n=[10:17 19:20]
%     out=readlcmtab(['~/scratch/N11_13/subs1_20/N11_13_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end
% 
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_021/special_rear2/lcm-out/special_rear2_DriftCorr2.table']);
% eval(['studystruct.N11_13_021=out;']);
% disp(['finished N11_13_021']);
% 
% for n=[22 25:29 31:37]
%     out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end
% 
% out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_038/special_rear2/lcm-out/special_rear2_DriftCorr2.table']);
% eval(['studystruct.N11_13_038=out;']);
% disp(['finished N11_13_038']);
% 
% for n=39
%     out=readlcmtab(['~/scratch/N11_13/subs21_39/N11_13_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end

% %%%%%%%%%%  THE FOLLOWING WILL WORK FOR N11_13_REAR (subjects 40 thru 79)
% %%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[40:45 47:52 54 56:65 67:75 77:79]
%     out=readlcmtab(['~/scratch/N11_13/subs40_79/N11_13_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end

%%%%%%%%%%  THE FOLLOWING WILL WORK FOR N11_13_FRONT (subjects 40 thru 79)
% %%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[40:52 54 56:65 67:75 77:79]
%     out=readlcmtab(['~/scratch/N11_13/subs40_79/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end

%%%%%%%%%%  THE FOLLOWING WILL WORK FOR N11_13_REAR (subjects 80 thru 96)
%%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[80:81 83:84 86 88:91 93:94 96]
%     out=readlcmtab(['~/scratch/N11_13/subs80_96/N11_13_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end

%%%%%%%%%%  THE FOLLOWING WILL WORK FOR N11_13_FRONT (subjects 80 thru 96)
% %%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[80:81 83:84 86 88:91 93:94 96]
%     out=readlcmtab(['~/scratch/N11_13/subs80_96/N11_13_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
%     eval(['studystruct.N11_13_0' num2str(n) '=out;']);
%     disp(['finished N11_13_0' num2str(n)]);
% end


%%%%%%%%%%  THE FOLLOWING WILL WORK FOR N09_14_REAR
%%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[1:9]
%     out=readlcmtab(['~/scratch/N09_14/N09_14_00' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N09_14_00' num2str(n) '=out;']);
%     disp(['finished N09_14_00' num2str(n)]);
% end
% for n=[10:25]
%     out=readlcmtab(['~/scratch/N09_14/N09_14_0' num2str(n) '/special_rear/lcm-out/special_rear_DriftCorr2.table']);
%     eval(['studystruct.N09_14_0' num2str(n) '=out;']);
%     disp(['finished N09_14_0' num2str(n)]);
% end

%%%%%%%%%%  THE FOLLOWING WILL WORK FOR N09_14_FRONT
%%%%%%%%%%  %%%%%%%%%%%%%%%%
% for n=[1:9]
%     out=readlcmtab(['~/scratch/N09_14/N09_14_00' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
%     eval(['studystruct.N09_14_00' num2str(n) '=out;']);
%     disp(['finished N09_14_00' num2str(n)]);
% end
% for n=[10:25]
%     out=readlcmtab(['~/scratch/N09_14/N09_14_0' num2str(n) '/special_front/lcm-out/special_front_DriftCorr2.table']);
%     eval(['studystruct.N09_14_0' num2str(n) '=out;']);
%     disp(['finished N09_14_0' num2str(n)]);
% end







% %%%%%%%%%%%%THE FOLLOWING CODE WILL WORK FOR bHG editoff study%%%%%%%%%%%%%%%%%%%%
% ns=[1320 1367 173 262 291 357 358 439 550 584 741 750 784 827 948]'
% 
% for n=1:15
%     disp(['~/scratch/bHG/VarianData/allSamples/sample' num2str(ns(n)) '/lcm-out/sample' num2str(ns(n)) '_editoff.table'])
% out=readlcmtab(['~/scratch/bHG/VarianData/allSamples/sample' num2str(ns(n)) '/lcm-out/sample' num2str(ns(n)) '_editoff.table']);
% eval(['studystruct.sample' num2str(ns(n)) '=out;']);
% disp(['finished sample' num2str(ns(n))]);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%



% %%%%%%%%%%THE CODE BELOW WILL WORK FOR N11_14%%%%%%%%%%%%%%%%%%%%%%%%
% for n=3:6
%     N{n}
%     out=readlcmtab(['~/scratch/N11_14/N11_14_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N11_14_' N{n} '=out;']);
%     disp(['finished N11_14_' N{n}]);
% end
% 
% for n=7
%     N{n}
%     out=readlcmtab(['~/scratch/N11_14/N11_14_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N11_14_' N{n} '=out;']);
%     disp(['finished N11_14_' N{n}]);
% end
% 
% for n=9:22
%     N{n}
%     out=readlcmtab(['~/scratch/N11_14/N11_14_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N11_14_' N{n} '=out;']);
%     disp(['finished N11_14_' N{n}]);
% end
% 
% for n=23
%     N{n}
%     out=readlcmtab(['~/scratch/N11_14/N11_14_' N{n} '/special/lcm-out/special.table']);
%     eval(['studystruct.N11_14_' N{n} '=out;']);
%     disp(['finished N11_14_' N{n}]);
% end
% 
% for n=24:34
%     N{n}
%     out=readlcmtab(['~/scratch/N11_14/N11_14_' N{n} '/special/lcm-out/special_DriftCorr2.table']);
%     eval(['studystruct.N11_14_' N{n} '=out;']);
%     disp(['finished N11_14_' N{n}]);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The following will work for Fabrice's study

%dirs=dir('/data/near/studies/Fabrice/');
dirs={'072','073','074'};
for n=1:3
    disp(dirs{n});
    out=readlcmtab(['/data/near/studies/Fabrice/81-' dirs{n} '/special/lcm-out/special_DriftCorr2a.table']);
    disp(dirs{n});
    eval(['studystruct.sub81_' dirs{n} '=out;']);
    disp(['finished ' dirs{n}]);
end







