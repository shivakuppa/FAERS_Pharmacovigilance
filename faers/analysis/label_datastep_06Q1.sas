/*PROC FORMAT;
	value $AGE_COD
	"DEC"="DECADE"
    "YR"="YEAR"
    "MON"="MONTH"
    "WK"="WEEK"
    "DY"="DAY"
    "HR"="HOUR"
	;
	value $GNDR
	"UNK"="Unknown"
	"M"="Male"
	"F"="Female"
	"NS"="Not Specified"
	;
	value $REPT
	"EXP"="Expdited"
	"PER"="Periodic"
	"DIR"="Direct"
	;
	value $WT
	"KG"="Kilograms"
	"LB"="Pounds"
	"GMS"="Grams"
	;
	value $OCCP
	"MD"="Physician"
	"PH"="Pharmacist"
	"OT"="Other health professional"
	"LW"="Lawyer"
	"CN"="Consumer"
	;
run;*/

data Demo1 (DROP=VAR24);
	set ARAW06.Demo06q1;
	label ISR = "Report's unique number"
		  CASE = "Case's unique number"
		  I_F_COD = "Intitial/Followup status code (I/F)"
		  FOLL_SEQ = "Followup report sequence number"
		  IMAGE = "Report's image identifier"
		  EVENT_DT = "Date that event began"
		  MFR_DT = "Date when manufacturer received data"
		  FDA_DT = "Date when FDA received data"
		  REPT_COD = "Code for type of report"
		  MFR_NUM = "Manufacturer's unique number"
		  MFR_SNDR = "Full name of manufacturer"
		  AGE = "Age of patient"
		  AGE_COD = "Unit abbreviation for patient age"
		  GNDR_COD = "Code for patient gender"
		  E_SUB = "Was report submitted with electronic procedures (Y/N)"
		  WT = "Weight of patient"
		  WT_COD = "Unit abbreviation for patient weight"
		  REPT_DT = "Date report was sent"
		  OCCP_COD = "Abbreviation for reporters occupation"
		  DEATH_DT = "Death date of patient"
		  TO_MFR = "Did reporter notify manufacturer"
		  CONFID = "Does reporter want identity confirmed"
		  COUNTRY = "Country of reporter"

	;

	/*Age derivation*/
	If AGE_COD="DY" THEN D_AGE=FLOOR(AGE/365);
	ELSE IF AGE_COD="HR" THEN D_AGE=FLOOR(AGE/8760);
	ELSE IF AGE_COD="MON" THEN D_AGE=FLOOR(AGE/12);
	ELSE IF AGE_COD="WK" THEN D_AGE=FLOOR(AGE/52);
	ELSE IF AGE_COD="DEC" THEN D_AGE=FLOOR(AGE*12);
	ELSE IF AGE_COD="YR" THEN D_AGE=FLOOR(AGE);

	/*Weight derivation*/
	If WT_COD="KG" THEN D_WT=FLOOR(WT);
	ELSE If WT_COD="LBS" THEN D_WT=FLOOR(WT*2.205);

	/*Age group derivation*/
	If D_AGE=. THEN D_GROUP=" ";
	ELSE If D_AGE<=25 THEN D_AGEGRP="GROUP 1";
	ELSE If D_AGE>=25 AND D_AGE<=50 THEN D_AGEGRP="GROUP 2";
	ELSE If D_AGE>=50 AND D_AGE<=75 THEN D_AGEGRP="GROUP 3";
	ELSE If D_AGE>=75 AND D_AGE<=100 THEN D_AGEGRP="GROUP 4";

	format AGE_COD $AGE_COD. GNDR_COD $GNDR. REPT_COD $REPT. WT_COD $WT. OCCP_COD $OCCP.;

run;

DATA AFINAL06.Demo06q1;
	set Demo1;
run;


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


PROC FORMAT;
	value $OUTC
	"DE"="Death"
	"LT"="Life-Threatening"
	"HO"="Hospitalization - Initial or Prolonged" 
	"DS"="Disability"
	"CA"="Congenital Anomaly"
	"RI"="Required Intervention to Prevent Permanent Impairment/Damage"
	"OT"="Other"
	;
run;

data Outc1 (DROP=VAR3);
	set ARAW06.Outc06q1;
	label ISR = "Report's unique number"
		  OUTC_COD = "Code for patient outcomes"
	;

	format OUTC_COD $OUTC.;

run;

DATA AFINAL06.Outc06q1;
	set Outc1;
run;


data Reac1 (DROP=VAR3);
	set ARAW06.Reac06q1;
	label ISR = "Report's unique number"
		  PT = "Preferred term to describe the event"
	;

run;

DATA AFINAL06.Reac06q1;
	set Reac1;
run;


PROC FORMAT;
	value $RPSR
	"FGN"="Foreign"
	"SDY"="Study"
	"LIT"="Literature"
	"CSM"="Consumer"
	"HP"="Health Professional"
	"UF"="User Facility"
	"CR"="Company Representative"
	"DT"="Distributor"
	"OTH"="Other"
	;
run;

data Rpsr1 (DROP=VAR3);
	set ARAW06.Rpsr06q1;
	label ISR = "Report's unique number"
		  RPSR_COD = "Code for initial source of report"
	;

	format RPSR_COD $RPSR.;

run;

DATA AFINAL06.Rpsr06q1;
	set Rpsr1;
run;


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
