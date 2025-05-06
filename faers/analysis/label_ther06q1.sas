/* *************************************************************************
* PROGRAM : label_ther06q1
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
	value $DUR
    "YR"="YEARS"
    "MON"="MONTHS"
    "WK"="WEEKS"
    "DY"="DAYS"
    "HR"="HOURS"
	"MIN"="MINUTES"
	"SEC"="SECONDS"
	;
run;

OPTIONS OBS=100;

data Ther1 (DROP=VAR7);
	set ARAW06.Ther06q1;
	label ISR = "Report's unique number"
		  DRUG_SEQ = "Number for identifying drug from ISR"
		  START_DT = "Date when drug therapy started"
		  END_DT = "Date when drug therapy ended"
		  DUR = "How long therapy took place"
		  DUR_COD = "Code for duration"

	;

	format DUR_COD $DUR.;

run;

ODS PDF FILE="C:\dev\faers\tlg\Ther1Listings.pdf";

PROC PRINT DATA=Ther1 label;
	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Therapy Listings";
run;

ODS PDF CLOSE;
