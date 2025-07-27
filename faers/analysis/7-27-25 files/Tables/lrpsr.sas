/* *************************************************************************
* PROGRAM : lrpsr.sas
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

ODS PDF FILE="C:\dev\faers\tlg\Rpsr1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Rpsr1 label;
	var ISR RPSR_COD;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Report Source Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
