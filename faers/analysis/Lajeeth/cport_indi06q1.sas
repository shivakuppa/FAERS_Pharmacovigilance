/* *************************************************************************
* PROGRAM : cport_indi06Q1
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

LIBNAME Araw06 "C:\Dev\FAERS\DATA\RAW\2006";

FILENAME tranfile "C:\Dev\FAERS\XPT\indi06q1_nfda.xpt";

PROC CPORT LIBRARY = Araw06 FILE = TRANFILE ;
SELECT indi06q1/MEMTYPE=data; 

RUN;
