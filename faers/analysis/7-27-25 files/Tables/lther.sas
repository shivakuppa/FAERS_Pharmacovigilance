/* *************************************************************************
* PROGRAM : lther.sas
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

/*PROC FORMAT;*/
/*	value $DUR*/
/*    "YR"="YEARS"*/
/*    "MON"="MONTHS"*/
/*    "WK"="WEEKS"*/
/*    "DY"="DAYS"*/
/*    "HR"="HOURS"*/
/*	"MIN"="MINUTES"*/
/*	"SEC"="SECONDS"*/
/*	;*/
/*run;*/

/*OPTIONS OBS=1000;*/

ODS PDF FILE="C:\dev\faers\tlg\Ther1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Ther1 label;
/*	var ISR DRUG_SEQ START_DT END_DT DUR DUR_COD DRV_DUR;*/
	var ISR DRUG_SEQ START_DT END_DT DRV_DUR;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Therapy Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
