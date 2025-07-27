/* *************************************************************************
* PROGRAM : ldrug.sas
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
/*	value $ROLE*/
/*	"PS"="Primary Suspect Drug"*/
/*	"SS"="Secondary Suspect Drug"*/
/*	"C"="Concomitant"*/
/*	"I"="Interacting"*/
/*	;*/
/*	value $VAL*/
/*	"1"="Validated trade name used"*/
/*	"2"="Verbatim name used"*/
/*	;*/
/*	value $DE*/
/*	"Y"="Positive dechallenge"*/
/*	"N"="Negative dechallenge"*/
/*	"U"="Unknown"*/
/*	"D"="Does not apply"*/
/*	;*/
/*	value $RE*/
/*	"Y"="Positive rechallenge"*/
/*	"N"="Negative rechallenge"*/
/*	"U"="Unknown"*/
/*	"D"="Does not apply"*/
/*	;*/
/*run;*/

/*OPTIONS OBS=100;*/

ODS PDF FILE="C:\dev\faers\tlg\Drug1Listings.pdf";

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Drug1 NOOBS;
	var ISR DRUG_SEQ ROLE_COD DRUGNAME VAL_VBM ROUTE DOSE_VBM DECHAL RECHAL
	LOT_NUM EXP_DTNDA_NUM;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Drug Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
