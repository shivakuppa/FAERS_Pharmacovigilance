/* *************************************************************************
* PROGRAM : areac.sas
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

data Reac1 (DROP=VAR3);
	set ARAW06.Reac06q1;
	label ISR = "Report's unique number"
		  PT = "Preferred term to describe the event"
	;

run;

DATA AFINAL06.Reac06q1;
	set Reac1;
run;
