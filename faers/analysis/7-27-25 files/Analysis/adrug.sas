/* *************************************************************************
* PROGRAM : adrug.sas
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
		  DER_DRUG = "Derived Drug Name"

	;



	format ROLE_COD $ROLE. VAL_VBM VAL. DECHAL $DE. RECHAL $RE.;

run;

DATA Drug2;
	set Drug1;

	IF DRUGNAME='*PLACEBO (*PLACEBO)' THEN DER_DRUG='PLACEBO';
	ELSE IF DRUGNAME IN ('',',','..',',,','...','....','.....','..........'
	'...........','............','.............','...............',
	'................','.................','..................',
	'...................','....................','.....................',
	'......................','........................','.........................'
	'///') THEN DELETE; 
	ELSE IF DRUGNAME IN ('1 CONCOMITANT DRUG (GENERIC UNKNOWN)','1 CONCOMITANT SUSPECTED DRUG',
	'1 CONCOMITANT UNSPECIFIED DRUG (GENERIC UNKNOWN)') THEN DER_DRUG='CONCOMITANT DRUG';
	
run;

DATA AFINAL06.Drug06q1;
	set Drug2;
run;
