/* *************************************************************************
* PROGRAM : xpt_reac06Q1
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

LIBNAME AXPT06 XPORT 'C:\dev\faers\xpt\exp_reac06q1.xpt';

PROC COPY IN=ARAW06 OUT=AXPT06;

	SELECT REAC06Q1/MEMTYPE=DATA;

RUN;
