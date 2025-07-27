/* *************************************************************************
* PROGRAM : aoutc.sas
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

PROC FORMAT;
	value $OUTC
	"DE"="Death"
	"LT"="Life-Threatening"
	"HO"="Hospitalization - Initial or Prolonged" 
	"DS"="Disability"
	"CA"="Congenital Anomaly"
	"RI"="Required Intervention to Prevent Permanent Impairment/Damage"
	"OT"="Other"
	;
run;

OPTIONS OBS=100;

data Outc1 (DROP=VAR3);
	set ARAW06.Outc06q1;
	label ISR = "Report's unique number"
		  OUTC_COD = "Code for patient outcomes"
	;

	format OUTC_COD $OUTC.;

run;

DATA AFINAL06.Outc06q1;
	set Outc1;
run;
