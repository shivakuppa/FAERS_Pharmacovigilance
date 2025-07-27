/* *************************************************************************
* PROGRAM : lreac.sas
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

/*OPTIONS OBS=100;*/

ODS PDF FILE="C:\dev\faers\tlg\Reac1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Reac1 label;
	var ISR PT;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Reaction Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;

/*PROC PRINT DATA=Demo1 label;
	label I_F_COD = "Intitial/Followup status code (I/F)";
run;*/
