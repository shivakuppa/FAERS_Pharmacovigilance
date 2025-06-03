/* *************************************************************************
* PROGRAM : label_indi06q1
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

ODS PDF FILE="C:\dev\faers\tlg\IndiListings.pdf"; 

%let name=Lajeeth Thangavel;

PROC PRINT DATA= Indi2 NOOBS;
	/*label I_F_COD = "Intitial/Followup status code (I/F)";*/
	var ISR DRUG_SEQ INDI_PT;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Indication Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;

title;
footnote;

/*PROC PRINT DATA=Demo1 label;
	label I_F_COD = "Intitial/Followup status code (I/F)";
run;*/
