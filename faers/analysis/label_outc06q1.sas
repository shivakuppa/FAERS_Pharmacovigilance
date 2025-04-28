/* *************************************************************************
* PROGRAM : label_outc06q1
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/25/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

OPTIONS OBS=100;

data Outc1 (DROP=VAR3);
	set ARAW06.Outc06q1;
	label ISR = "Report's unique number"
		  OUTC_COD = "Code for patient outcomes"
	;

run;

/*PROC PRINT DATA=Demo1 label;
	label I_F_COD = "Intitial/Followup status code (I/F)";
run;*/
