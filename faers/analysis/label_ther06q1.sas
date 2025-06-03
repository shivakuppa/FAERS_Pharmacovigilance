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

OPTIONS OBS=1000;

data Ther1 (DROP=VAR7);
	set ARAW06.Ther06q1;
	label ISR = "Report's unique number"
		  DRUG_SEQ = "Number for identifying drug from ISR"
		  START_DT = "Date when drug therapy started"
		  END_DT = "Date when drug therapy ended"
		  DUR = "How long therapy took place"
		  DUR_COD = "Code for duration"

	;

	/*Derived missing start and end date*/
	IF DUR_COD="" THEN DO;
		IF START_DT=. THEN START_DT=END_DT;
		ELSE IF END_DT=. THEN END_DT=START_DT;
		END; 

	/*If Duration and Duration Code is missing but start and end date not missing*/
	IF DUR_COD="" AND DUR=. THEN DO;
		TEMP_DUR=(END_DT-START_DT);
		END; 

	/*If Temp Duration is missing*/
	IF TEMP_DUR="" THEN DO;
		TEMP_DUR=DUR;
		DER_DUR=DUR;
		END;

	IF DUR=. THEN DO;
		TEMP_DUR=ABS((END_DT-START_DT)+1);
		DER_DUR=TEMP_DUR;
		END;

	/*Temp duration, Duration, and end date is missing*/
	IF DUR_COD="" AND DUR=. AND END_DT=. THEN DO;
		IF START_DT^=. AND TEMP_DUR^=. THEN DO;
			END_DT = START_DT + TEMP_DUR - 1;
			END;
		ELSE IF START_DT^=. AND DUR^=. THEN DO;
			END_DT = START_DT + DUR - 1;
		END;
	END;

	/*Temp duration, Duration, and start date is missing*/
	IF DUR_COD="" AND DUR=. AND START_DT=. THEN DO;
		IF END_DT^=. AND TEMP_DUR^=. THEN DO;
			START_DT = END_DT - TEMP_DUR + 1;
			END;
		ELSE IF END_DT^=. AND DUR^=. THEN DO;
			START_DT = END_DT - DUR + 1;
		END;
	END;

		/*Derive if Duration is 0, add 1 day*/
	IF DUR=0 AND START_DT^=. THEN DO;
		END_DT = START_DT + 1;
		TEMP_DUR = 1;
		DER_DUR = 1;
		END;

	/*Duration derivation*/
	If DUR_COD="DAYS" THEN DER_DUR=FLOOR(DUR/365);
	ELSE IF DUR_COD="HOURS" THEN DER_DUR=FLOOR(DUR/8760);
	ELSE IF DUR_COD="MONTHS" THEN DER_DUR=FLOOR(DUR/12);
	ELSE IF DUR_COD="WEEKS" THEN DER_DUR=FLOOR(DUR/52);
	ELSE IF DUR_COD="MINUTES" THEN DER_DUR=FLOOR(DUR/525600);
	ELSE IF DUR_COD="SECONDS" THEN DER_DUR=FLOOR(DUR/31536000);
	ELSE IF DUR_COD="YEARS" THEN DER_DUR=FLOOR(DUR);

	format DUR_COD $DUR.;

run;

ODS PDF FILE="C:\dev\faers\tlg\Ther1Listings.pdf";

%let name=Lajeeth Thangavel;

DATA Ther2;
	set Ther1;
run;

DATA AFINAL06.Ther06q1;
	set Demo1;
run;

PROC FREQ DATA=Ther2;
	table DUR;
run;

PROC PRINT DATA=Ther1 label;
	var ISR DRUG_SEQ START_DT END_DT DUR DUR_COD;

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Therapy Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;
