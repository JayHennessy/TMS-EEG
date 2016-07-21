function [Subjects,Metabs]=writelcm2xls(study_struct,outfile);
%function [Subjects,Metabs]=writelcm2xls(study_struct,outfile);
%This function takes a structure containing all of the data from an MRS
%study, and converts it into a text file that can be read into Microsoft
%Excel.

%study_struct is structure whose fields are structures representing each
%individual subject in the study.  The fields of the subject structures
%contain the metabolite concentrations and uncertainty measurements.
%ie:  N10_01.N10_01_001.GABA=0.135;  N10_01.N10_01_001.d_GABA=13 (%)

%outfile is the name of the text file to be output.


Subjects=fieldnames(study_struct);
eval(['Metabs=fieldnames(study_struct.' Subjects{1} ');']);

seq=input('PRESS (P) or SPECIAL (S) or VarianPress (V)? ','s');

if seq=='S' || seq=='s'
    nMetabsUsed=21;
    %write to txt file for jmrui
    fid=fopen(outfile,'w+');
    fprintf(fid,'Microsoft Excel Data Textfile');
    fprintf(fid,'\nSubject');
    fprintf(fid,'\tAla');
    fprintf(fid,'\t\tAsp');
    fprintf(fid,'\t\tPCh');
    fprintf(fid,'\t\tCr');
    fprintf(fid,'\t\tPCr');
    fprintf(fid,'\t\tGABA');
    fprintf(fid,'\t\tGln');
    fprintf(fid,'\t\tGlu');
    fprintf(fid,'\t\tGSH');
    fprintf(fid,'\t\tGly');
    fprintf(fid,'\t\tIns');
    fprintf(fid,'\t\tLac');
    fprintf(fid,'\t\tNAA');
    fprintf(fid,'\t\tScyllo');
    fprintf(fid,'\t\tTau');
    fprintf(fid,'\t\tGlc');
    fprintf(fid,'\t\tNAAG');
    fprintf(fid,'\t\tGPC');
    fprintf(fid,'\t\tPE');
    fprintf(fid,'\t\tSer');
    fprintf(fid,'\t\tbHB\n');
    
    for n=1:nMetabsUsed
        fprintf(fid,'\tConc');
        fprintf(fid,'\tSD');
    end
    
    fprintf(fid,'\tFWHM');
    fprintf(fid,'\tSNR');
    
    
    for n=1:length(Subjects);
        
        fprintf(fid,'\n%s' ,Subjects{n});
        for m=1:nMetabsUsed
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m-1} ';']);
            fprintf(fid,'\t%1.3E',value);
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m} ';']);
            fprintf(fid,'\t%i',value);
        end
        eval(['value=study_struct.' Subjects{n} '.FWHM;']);
        fprintf(fid,'\t%1.3f',value);
        eval(['value=study_struct.' Subjects{n} '.SNR;']);
        fprintf(fid,'\t%i',value);
    end
    
elseif seq=='P' || seq=='p'
    nMetabsUsed=22;
    %write to txt file for jmrui
    fid=fopen(outfile,'w+');
    fprintf(fid,'Microsoft Excel Data Textfile');
    fprintf(fid,'\nSubject');
    fprintf(fid,'\tAla');
    fprintf(fid,'\t\tAsp');
    fprintf(fid,'\t\tCr');
    fprintf(fid,'\t\tPCr');
    fprintf(fid,'\t\tGABA');
    fprintf(fid,'\t\tGlc');
    fprintf(fid,'\t\tGln');
    fprintf(fid,'\t\tGlu');
    fprintf(fid,'\t\tGPC');
    fprintf(fid,'\t\tPCh');
    fprintf(fid,'\t\tIns');
    fprintf(fid,'\t\tLac');
    fprintf(fid,'\t\tNAA');
    fprintf(fid,'\t\tNAAG');
    fprintf(fid,'\t\tScyllo');
    fprintf(fid,'\t\tTau');
    fprintf(fid,'\t\tCrCH2');
    fprintf(fid,'\t\tGua');
    fprintf(fid,'\t\tGPC+PCh');
    fprintf(fid,'\t\tNAA+NAAG');
    fprintf(fid,'\t\tCr+PCr');
    fprintf(fid,'\t\tGlu+Gln\n');
    
    for n=1:nMetabsUsed
        fprintf(fid,'\tConc');
        fprintf(fid,'\tSD');
    end
    
    fprintf(fid,'\tFWHM');
    fprintf(fid,'\tSNR');
    
    
    for n=1:length(Subjects);
        
        fprintf(fid,'\n%s' ,Subjects{n});
        for m=1:nMetabsUsed
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m-1} ';']);
            fprintf(fid,'\t%1.3E',value);
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m} ';']);
            fprintf(fid,'\t%i',value);
        end
        eval(['value=study_struct.' Subjects{n} '.FWHM;']);
        fprintf(fid,'\t%1.3f',value);
        eval(['value=study_struct.' Subjects{n} '.SNR;']);
        fprintf(fid,'\t%i',value);
    end
    
elseif seq=='V' || seq=='v'
    nMetabsUsed=23;
    %write to txt file for jmrui
    fid=fopen(outfile,'w+');
    fprintf(fid,'Microsoft Excel Data Textfile');
    fprintf(fid,'\nSubject');
    fprintf(fid,'\tAla');
    fprintf(fid,'\t\tAsp');
    fprintf(fid,'\t\tPCh');
    fprintf(fid,'\t\tCr');
    fprintf(fid,'\t\tPCr');
    fprintf(fid,'\t\tGABA');
    fprintf(fid,'\t\tGln');
    fprintf(fid,'\t\tGlu');
    fprintf(fid,'\t\tGSH');
    fprintf(fid,'\t\tGly');
    fprintf(fid,'\t\tIns');
    fprintf(fid,'\t\tLac');
    fprintf(fid,'\t\tNAA');
    fprintf(fid,'\t\tScyllo');
    fprintf(fid,'\t\tTau');
    fprintf(fid,'\t\tAsc');
    fprintf(fid,'\t\tbHB');
    fprintf(fid,'\t\tbHG');
    fprintf(fid,'\t\tGlc');
    fprintf(fid,'\t\tNAAG');
    fprintf(fid,'\t\tGPC');
    fprintf(fid,'\t\tPE');
    fprintf(fid,'\t\tSer\n');
    
    
    for n=1:nMetabsUsed
        fprintf(fid,'\tConc');
        fprintf(fid,'\tSD');
    end
    
    fprintf(fid,'\tFWHM');
    fprintf(fid,'\tSNR');
    
    
    for n=1:length(Subjects);
        
        fprintf(fid,'\n%s' ,Subjects{n});
        for m=1:nMetabsUsed
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m-1} ';']);
            fprintf(fid,'\t%1.3E',value);
            eval(['value=study_struct.' Subjects{n} '.' Metabs{2*m} ';']);
            fprintf(fid,'\t%i',value);
        end
        eval(['value=study_struct.' Subjects{n} '.FWHM;']);
        fprintf(fid,'\t%1.3f',value);
        eval(['value=study_struct.' Subjects{n} '.SNR;']);
        fprintf(fid,'\t%i',value);
    end
end




    


fclose(fid);