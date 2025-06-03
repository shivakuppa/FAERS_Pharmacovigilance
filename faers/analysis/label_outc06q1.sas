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

ODS PDF FILE="C:\dev\faers\tlg\Outc1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Outc1 label;
	var ISR OUTC_COD;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Outcome Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
