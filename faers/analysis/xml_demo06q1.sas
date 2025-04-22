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

OPTIONS OBS=100;

LIBNAME AXML06 XML 'C:\dev\faers\xml\exp_demo06q1.xml';

PROC COPY IN=Araw06 OUT=Axml06;
SELECT demo06q1/MEMTYPE=DATA;
RUN;
