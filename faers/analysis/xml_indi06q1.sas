/* *************************************************************************
* PROGRAM : xml_indi06Q1
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

LIBNAME AXML06 XPORT 'C:\dev\faers\xml\exp_indi06q1.xml';

PROC COPY IN=ARAW06 OUT=AXML06;

	SELECT INDI06Q1/MEMTYPE=DATA;

RUN;
