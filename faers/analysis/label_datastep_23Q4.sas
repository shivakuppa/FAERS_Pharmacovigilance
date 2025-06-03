/**************************************************************************************************
* PROGRAM : imp_2023
* PROGRAMMER : Shiva Kuppa
* VALIDATOR: Lajeeth
* DATE : 4/7/2025
* PURPOSE : C:\dev\faers\data\raw\2023
* SOURCE: C:\dev\faers\analysis
*
* MODIFYING HISTORY
***************************************************************************************************
DATE:                   NAME:                       REASON FOR MODIFICATION:
***************************************************************************************************
*/

%let name = Shiva Kuppa;

OPTIONS OBS=1000;

/* DEMOGRAPHIC DATA */
DATA demo23_d;
	SET ARAW23.Demo23q4;

	/* AGE DERIVATION */
	IF AGE_COD = "DEC" THEN D_AGE = FLOOR(AGE * 10);
	ELSE IF AGE_COD = "YR" THEN D_AGE = FLOOR(AGE);
	ELSE IF AGE_COD = "MON" THEN D_AGE = FLOOR(AGE / 12);
	ELSE IF AGE_COD = "WK"  THEN D_AGE = FLOOR(AGE / 52);
	ELSE IF AGE_COD = "DY"  THEN D_AGE = FLOOR(AGE / 365);
	ELSE IF AGE_COD = "HR"  THEN D_AGE = FLOOR(AGE / 8760);

	/* WEIGHT DERIVATION */
	IF WT_COD = "KG" THEN D_WT = WT;
	ELSE IF WT_COD = "LBS" THEN D_WT = WT / 2.20462;
	ELSE IF WT_COD = "GMS" THEN D_WT = WT / 1000;

	/* LABELS */
	LABEL PRIMARYID = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  CASEVERSION = "Safety Report Version Number."
		  I_F_CODE = "Initial or follow-up status"
		  EVENT_DT = "Event date"
		  MFR_DT = "Date manufacturer first received"
		  INIT_FDA_DT = "Date FDA received initial"
		  FDA_DT = "Date FDA received"
		  REPT_COD = "Type of report submitted"
		  AUTH_NUM = "Authority case report number"
		  MFR_NUM = "Manufacturer's unique report ID"
		  MFR_SNDR = "Manufacturer sender"
		  LIT_REF = "Literature reference"
		  AGE = "Age at event"
		  AGE_COD = "Age unit"
		  AGE_GRP = "Age group"
		  SEX = "Sex"
		  E_SUB = "Electronic submission (Y/N)"
		  WT = "Weight"
		  WT_COD = "Weight unit"
		  REPT_DT = "Report date"
		  TO_MFR = "Reported to manufacturer"
		  OCCP_COD = "Reporter occupation"
		  REPORTER_COUNTRY = "Reporter country"
		  OCCR_COUNTRY = "Occurrence country"
		  D_AGE = "Derived age (years)"
		  D_WT = "Derived weight (kg)";
RUN;

DATA AFINAL23.demo23_d;
	set demo23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Demo1Listings.pdf";
PROC PRINT DATA=demo23_d NOOBS;
	VAR PRIMARYID CASEID CASEVERSION EVENT_DT FDA_DT MFR_DT 
	    AGE AGE_COD D_AGE SEX WT WT_COD D_WT 
	    REPORTER_COUNTRY OCCR_COUNTRY 
	    I_F_CODE REPT_COD OCCP_COD E_SUB TO_MFR;
	WHERE AGE^=. AND SEX^="";
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Demographic Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* DRUG DATA */
DATA drug23_d;
	SET ARAW23.Drug23q4;
	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  DRUG_SEQ = "Drug sequence number"
		  ROLE_COD = "Role of drug"
		  DRUGNAME = "Drug name"
		  PROD_AI = "Active ingredient"
		  VAL_VBM = "Source code"
		  ROUTE = "Administration route"
		  DOSE_VBM = "Dose verbatim"
		  CUM_DOSE_CHR = "Cumulative dose"
		  CUM_DOSE_UNIT = "Cumulative dose unit"
		  DECHAL = "Dechallenge result"
		  RECHAL = "Rechallenge result"
		  LOT_NUM = "Lot number"
		  EXP_DT = "Expiration date"
		  NDA_NUM = "NDA number"
		  DOSE_AMT = "Dose amount"
		  DOSE_UNI = "Dose unit"
		  DOSE_FORM = "Dose form"
		  DOSE_FREQ = "Dose frequency";
RUN;

DATA AFINAL23.drug23_d;
	set drug23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Drug1Listings.pdf";
PROC PRINT DATA=drug23_d NOOBS;
	VAR PRIMARYID CASEID DRUG_SEQ ROLE_COD DRUGNAME PROD_AI ROUTE DOSE_VBM;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Drug Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* INDICATION DATA */
DATA indi23_d;
	SET ARAW23.Indi23q4;
	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  INDI_DRUG_SEQ = "Drug sequence number"
		  INDI_PT = "Indication term";
RUN;

DATA AFINAL23.indi23_d;
	set indi23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Indi1Listings.pdf";
PROC PRINT DATA=indi23_d NOOBS;
	VAR PRIMARYID CASEID INDI_DRUG_SEQ INDI_PT;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Indications Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* OUTCOME DATA */
DATA outc23_d;
	SET ARAW23.Outc23q4;
	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  OUTC_COD = "Outcome code";
RUN;

DATA AFINAL23.outc23_d;
	set outc23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Outc1Listings.pdf";
PROC PRINT DATA=outc23_d NOOBS;
	VAR PRIMARYID CASEID OUTC_COD;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Outcomes Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* REACTION DATA */
DATA reac23_d;
	SET ARAW23.Reac23q4;
	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  PT = "Preferred term"
		  DRUG_REC_ACT = "Drug Recur Action";
RUN;

DATA AFINAL23.reac23_d;
	set reac23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Reac1Listings.pdf";
PROC PRINT DATA=reac23_d NOOBS;
	VAR PRIMARYID CASEID PT DRUG_REC_ACT;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Reactions Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* REPORT SOURCE DATA */
DATA rpsr23_d;
	SET ARAW23.Rpsr23q4;
	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  RPSR_COD = "Report source code";
RUN;

DATA AFINAL23.rpsr23_d;
	set rpsr23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Rpsr1Listings.pdf";
PROC PRINT DATA=rpsr23_d NOOBS;
	VAR PRIMARYID CASEID RPSR_COD;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Report Source Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;

/* THERAPY DATA */
DATA ther23_d;
	SET ARAW23.Ther23q4;

	IF DUR_COD="" THEN DO;
		IF START_DT=. THEN START_DT=END_DT;
		ELSE IF END_DT=. THEN END_DT=START_DT;
	END;

	IF DUR_COD="" AND DUR=. THEN TEMP_DUR = (END_DT-START_DT);

	IF TEMP_DUR="" THEN DO;
		TEMP_DUR = DUR;
		DER_DUR = DUR;
	END;

	IF DUR=. THEN DO;
		TEMP_DUR = ABS((END_DT-START_DT)+1);
		DER_DUR = TEMP_DUR;
	END;

	IF DUR_COD="" AND DUR=. AND END_DT=. THEN DO;
		IF START_DT^=. AND TEMP_DUR^=. THEN END_DT = START_DT + TEMP_DUR - 1;
		ELSE IF START_DT^=. AND DUR^=. THEN END_DT = START_DT + DUR - 1;
	END;

	IF DUR_COD="" AND DUR=. AND START_DT=. THEN DO;
		IF END_DT^=. AND TEMP_DUR^=. THEN START_DT = END_DT - TEMP_DUR + 1;
		ELSE IF END_DT^=. AND DUR^=. THEN START_DT = END_DT - DUR + 1;
	END;

	IF DUR=0 AND START_DT^=. THEN DO;
		END_DT = START_DT + 1;
		TEMP_DUR = 1;
		DER_DUR = 1;
	END;

	IF DUR_COD="DAYS" THEN DER_DUR=FLOOR(DUR/365);
	ELSE IF DUR_COD="HOURS" THEN DER_DUR=FLOOR(DUR/8760);
	ELSE IF DUR_COD="MONTHS" THEN DER_DUR=FLOOR(DUR/12);
	ELSE IF DUR_COD="WEEKS" THEN DER_DUR=FLOOR(DUR/52);
	ELSE IF DUR_COD="MINUTES" THEN DER_DUR=FLOOR(DUR/525600);
	ELSE IF DUR_COD="SECONDS" THEN DER_DUR=FLOOR(DUR/31536000);
	ELSE IF DUR_COD="YEARS" THEN DER_DUR=FLOOR(DUR);

	LABEL PRIMARYID = "FAERS report ID"
		  CASEID = "FAERS case ID"
		  DSG_DRUG_SEQ = "Drug sequence number"
		  START_DT = "Start date"
		  END_DT = "End date"
		  DUR = "Duration"
		  DUR_COD = "Duration code";
RUN;

DATA AFINAL23.ther23_d;
	set ther23_d;
RUN;

ODS PDF FILE="C:\dev\faers\tlg\Ther1Listings.pdf";
PROC PRINT DATA=ther23_d NOOBS;
	VAR PRIMARYID CASEID DSG_DRUG_SEQ START_DT END_DT DUR DUR_COD;
	TITLE "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	TITLE2 "Therapy Listings";
	FOOTNOTE "&sysdate. &systime. Author=&name.";
RUN;
ODS PDF CLOSE;
