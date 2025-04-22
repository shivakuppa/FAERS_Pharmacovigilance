/* *************************************************************************
* PROGRAM : imp_demo06Q1
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


PROC PRINTTO LOG="C:\dev\faers\log\DEMO06Q1.LOG" NEW;
RUN;

PROC IMPORT OUT= WORK.Demo06Q1 
            DATAFILE= "C:\dev\faers\data\raw\2006\DEMO06Q1.TXT" 
            DBMS=DLM REPLACE;
     DELIMITER='24'x; 
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=1000; 
RUN;

PROC PRINTTO;
RUN;
