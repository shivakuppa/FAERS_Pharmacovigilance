/* *************************************************************************
* PROGRAM : arpsr.sas
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
	value $RPSR
	"FGN"="Foreign"
	"SDY"="Study"
	"LIT"="Literature"
	"CSM"="Consumer"
	"HP"="Health Professional"
	"UF"="User Facility"
	"CR"="Company Representative"
	"DT"="Distributor"
	"OTH"="Other"
	;
run;

/*OPTIONS OBS=100;*/

data Rpsr1 (DROP=VAR3);
	set ARAW06.Rpsr06q1;
	label ISR = "Report's unique number"
		  RPSR_COD = "Code for initial source of report"
	;

	format RPSR_COD $RPSR.;

run;

DATA AFINAL06.Rpsr06q1;
	set Rpsr1;
run;
