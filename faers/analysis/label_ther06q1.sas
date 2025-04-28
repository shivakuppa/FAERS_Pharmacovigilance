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

run;

/*PROC PRINT DATA=Demo1 label;
	label I_F_COD = "Intitial/Followup status code (I/F)";
run;*/
