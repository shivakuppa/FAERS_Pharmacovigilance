/* *************************************************************************
* PROGRAM : expxls_drug06Q1
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

OPTION OBS=1000;

PROC EXPORT DATA= ARAW06.DRUG06Q1 
            OUTFILE= "C:\dev\faers\data\raw\2006\drug06q1.xls" 
            DBMS=EXCEL REPLACE;
     GETNAMES=YES;
RUN;
