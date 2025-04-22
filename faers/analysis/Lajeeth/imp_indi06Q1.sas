/* *************************************************************************
* PROGRAM : imp_indi06Q1
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/7/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

PROC PRINTTO LOG="C:\dev\faers\log\INDI06Q1.LOG" NEW;
RUN;

PROC IMPORT OUT= WORK.Indi06Q1 
            DATAFILE= "C:\dev\faers\data\raw\2006\INDI06Q1.TXT" 
            DBMS=DLM REPLACE;
     DELIMITER='24'x; 
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=1000; 
RUN;

PROC PRINTTO;
RUN;
