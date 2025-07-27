/* *************************************************************************
* PROGRAM : aindi.sas
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

data Indi1 (DROP=VAR4);
	set ARAW06.Indi06q1;
	label ISR = "Report's unique number"
		  DRUG_SEQ = "Number for identifying drug from ISR"
		  INDI_PT = "Preferred term to describe the event"
	;

run;

DATA AFINAL06.Indi06q1;
	set Indi1;
run;

DATA Indi2;
	set AFINAL06.Indi06q1;
RUN;
