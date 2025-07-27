/* *************************************************************************
* PROGRAM : loutc.sas
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

ODS PDF FILE="C:\dev\faers\tlg\Outc1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Outc1 label;
	var ISR OUTC_COD;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Outcome Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
