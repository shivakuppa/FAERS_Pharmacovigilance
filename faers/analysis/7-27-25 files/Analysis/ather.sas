/* *************************************************************************
* PROGRAM : ather.sas
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

data Ther1 (DROP=VAR7);
	set ARAW06.Ther06q1;
	label ISR = "Report's unique number"
		  DRUG_SEQ = "Number for identifying drug from ISR"
		  START_DT = "Date when drug therapy started"
		  END_DT = "Date when drug therapy ended"
		  DUR = "How long therapy took place"
		  DUR_COD = "Code for duration"
		  DER_DUR = "Derived Date"
		  DRV_DUR = "Derived Duration"

	;

	/*Derived missing start and end date*/

	IF DUR_COD = "" AND END_DT = . THEN DO;
		END_DT=START_DT;
	END;

	IF DUR_COD = "" AND START_DT = . THEN DO;
		START_DT=END_DT;
	END;

	IF START_DT = " " AND DUR_COD ^= " " AND DUR = . THEN DO;
		START_DT = END_DT;
	END;

	IF START_DT = 51101 THEN START_DT = 20051101;

	IF ISR = 4872193 THEN DO;
		END_DT = 20050306;
	END;

	IF START_DT > END_DT THEN DO;
		END_DT=START_DT;
	END;

	/*Converting numeric dates to character	*/
	STARTDTC = PUT(START_DT,10.);
	ENDDTC = PUT(END_DT,10.);

	IF DUR_COD = " " AND DUR = . THEN DO;
		START_N = INPUT(STARTDTC, YYMMDD10.);
		END_N = INPUT(ENDDTC, YYMMDD10.);
	END;

	/*Deriving duration	*/

	IF DUR_COD = " " AND DUR = . THEN DO;
		DRV_DUR=FLOOR(((END_N-START_N)+1)/365.25);
	END;

	/*If duration code is avaliable, change to years	*/
	IF DUR_COD ^= " " AND DUR ^= . THEN DO;
		IF DUR_COD="DAY" THEN DER_DUR=FLOOR(DUR/365.25);
		ELSE IF DUR_COD="HR" THEN DER_DUR=FLOOR(DUR/8760);
		ELSE IF DUR_COD="MON" THEN DER_DUR=FLOOR(DUR/12);
		ELSE IF DUR_COD="WK" THEN DER_DUR=FLOOR(DUR/52);
		ELSE IF DUR_COD="MIN" THEN DER_DUR=FLOOR(DUR/525600);
		ELSE IF DUR_COD="SEC" THEN DER_DUR=FLOOR(DUR/31536000);
		ELSE IF DUR_COD="YR" THEN DER_DUR=FLOOR(DUR);
	END;

	IF DRV_DUR = . THEN DO;
		DRV_DUR = DER_DUR;
	END;

	IF DRV_DUR = . AND DUR ^= . THEN DO;
		DRV_DUR = FLOOR(DUR/365.25);
	END;

	IF DUR_COD ^= " " AND DUR = . THEN DO;
		START_N = INPUT(STARTDTC, YYMMDD10.);
		END_N = INPUT(ENDDTC, YYMMDD10.);
		DRV_DUR=FLOOR(((END_N-START_N)+1)/365.25);
	END;

	IF DRV_DUR IN (1489,999,896,878,821,756,732,731,700,618,341,165,162,160,149,147,144
	134,112) THEN DO;
		DRV_DUR = FLOOR(DUR/365.25);
	END;

	format DUR_COD $DUR.;

run;

DATA AFINAL06.Ther06q1;
	set Ther1;
run;
