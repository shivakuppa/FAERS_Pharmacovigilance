/* *************************************************************************
* PROGRAM : label_drug06q1
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
	value $ROLE
	"PS"="Primary Suspect Drug"
	"SS"="Secondary Suspect Drug"
	"C"="Concomitant"
	"I"="Interacting"
	;
	value $VAL
	"1"="Validated trade name used"
	"2"="Verbatim name used"
	;
	value $DE
	"Y"="Positive dechallenge"
	"N"="Negative dechallenge"
	"U"="Unknown"
	"D"="Does not apply"
	;
	value $RE
	"Y"="Positive rechallenge"
	"N"="Negative rechallenge"
	"U"="Unknown"
	"D"="Does not apply"
	;
run;

OPTIONS OBS=100;

data Drug1 (DROP=VAR13);
	set ARAW06.Drug06q1;
	label ISR = "Report's unique number"
		  DRUG_SEQ = "Number for identifying drug from ISR"
		  ROLE_COD = "Code for the role drug played in event"
		  DRUGNAME = "Name of drug"
		  VAL_VBM = "Code for source of drug name"
		  ROUTE = "Route of drug administration"
		  DOSE_VBM = "Exact text for dose, frequency and route"
		  DECHAL = "Dechallenge code (reaction when drug therapy stopped)"
		  RECHAL = "Rechallenge code (reaction when drug therapy restarted)"
		  LOT_NUM = "Lot number of drug"
		  EXP_DT = "Expiration date of drug"
		  NDA_NUM = "NDA number"

	;

	format ROLE_COD $ROLE. VAL_VBM $VAL. DECHAL $DE. RECHAL $RE.

run;

ODS PDF FILE="C:\dev\faers\tlg\Drug1Listings.pdf";

PROC PRINT DATA=Drug1 label;
	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Drug Listings";
run;

ODS PDF CLOSE;
