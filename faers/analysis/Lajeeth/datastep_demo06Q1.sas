/* *************************************************************************
* PROGRAM : datastep_demo06Q1
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/2/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

*Global Options;
OPTIONS LINESIZE=120 PAGESIZE=54 ORIENTATION=LANDSCAPE OBS=MAX NOFMTERR VALIDVARNAME=V6
		MERROR SERROR MPRINT MLOGIC SYMBOLGEN;

LIBNAME ARAW06 'C:\dev\faers\data\raw\2006';

PROC PRINTTO LOG='C:\dev\faers\log\datastep_demo06Q1.log' NEW;
RUN;

data ARAW06.Demo06Q1 (DROP=VAR24)   ;
       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
       infile 'C:\dev\faers\data\raw\2006\DEMO06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767
	   firstobs=2 ;
          informat ISR best32. ;
          informat CASE best32. ;
          informat I_F_COD $1. ;
          informat FOLL_SEQ best32. ;
          informat IMAGE $9. ;
          informat EVENT_DT best32. ;
          informat MFR_DT best32. ;
          informat FDA_DT best32. ;
          informat REPT_COD $3. ;
          informat MFR_NUM $61. ;
          informat MFR_SNDR $49. ;
          informat AGE best32. ;
          informat AGE_COD $3. ;
          informat GNDR_COD $3. ;
          informat E_SUB $1. ;
          informat WT best32. ;
          informat WT_COD $3. ;
          informat REPT_DT best32. ;
          informat OCCP_COD $2. ;
          informat DEATH_DT best32. ;
          informat TO_MFR $1. ;
          informat CONFID $1. ;
          informat COUNTRY $25. ;
          informat VAR24 $1. ;
          format ISR best12. ;
          format CASE best12. ;
          format I_F_COD $1. ;
          format FOLL_SEQ best12. ;
          format IMAGE $9. ;
          format EVENT_DT best12. ;
          format MFR_DT best12. ;
          format FDA_DT best12. ;
          format REPT_COD $3. ;
          format MFR_NUM $61. ;
          format MFR_SNDR $49. ;
          format AGE best12. ;
          format AGE_COD $3. ;
          format GNDR_COD $3. ;
          format E_SUB $1. ;
          format WT best12. ;
          format WT_COD $3. ;
          format REPT_DT best12. ;
          format OCCP_COD $2. ;
          format DEATH_DT best12. ;
          format TO_MFR $1. ;
          format CONFID $1. ;
          format COUNTRY $25. ;
          format VAR24 $1. ;
       input
                   ISR
                   CASE
                   I_F_COD $
                   FOLL_SEQ
                   IMAGE $
                   EVENT_DT
                   MFR_DT
                   FDA_DT
                   REPT_COD $
                   MFR_NUM $
                   MFR_SNDR $
                   AGE
                   AGE_COD $
                   GNDR_COD $
                   E_SUB $
                   WT
                   WT_COD $
                   REPT_DT
                   OCCP_COD $
                   DEATH_DT
                   TO_MFR $
                   CONFID $
                   COUNTRY $
                   VAR24 $
       ;
       if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
	   KEEP ISR GNDR_COD;
       run;

PROC PRINTTO;
RUN;
