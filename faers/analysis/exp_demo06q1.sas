/* *************************************************************************
* PROGRAM : exp_demo06Q1
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/9/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

PROC EXPORT DATA= ARAW06.DEMO06Q1 
            OUTFILE= "C:\dev\faers\data\raw\2006\demo06q1.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
