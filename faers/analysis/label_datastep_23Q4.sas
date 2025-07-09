/**************************************************************************************************
* PROGRAM : imp_2023
* PROGRAMMER : Shiva Kuppa
* VALIDATOR: Lajeeth
* DATE : 4/7/2025
* PURPOSE : C:\dev\faers\data\raw\2023
* SOURCE: C:\dev\faers\analysis
* 
*
* MODIFYING HISTORY
***************************************************************************************************
DATE:                   NAME:                       REASON FOR MODIFICATION:
***************************************************************************************************
*/

/*OPTIONS VALIDVARNAME=ANY;*/

DATA Afinal23.demo23_d;
	SET ARAW23.Demo23q4;

	/* AGE DERIVATION */
	IF AGE_COD = "DEC" 
	THEN D_AGE = FLOOR(AGE * 10);

	ELSE IF AGE_COD = "YR" 
	THEN D_AGE = FLOOR(AGE);

	ELSE IF AGE_COD = "MON" 
	THEN D_AGE = FLOOR(AGE / 12);

	ELSE IF AGE_COD = "WK"  
	THEN D_AGE = FLOOR(AGE / 52);

	ELSE IF AGE_COD = "DY"  
	THEN D_AGE = FLOOR(AGE / 365);

	ELSE IF AGE_COD = "HR"  
	THEN D_AGE = FLOOR(AGE / 8760);

	/* WEIGHT DERIVATION */
	IF WT_COD = "KG"
	THEN D_WT = WT;

	ELSE IF WT_COD = "LBS"
	THEN D_WT = WT / 2.20462;

	ELSE IF WT_COD = "GMS"
	THEN D_WT = WT / 1000;

	/* AGE GROUP DERIVATION */
    IF D_AGE >= 0 AND D_AGE <= 25 THEN D_AGEGRP = "GROUP1";
    ELSE IF D_AGE >= 26 AND D_AGE <= 50 THEN D_AGEGRP = "GROUP2";
    ELSE IF D_AGE >= 51 AND D_AGE <= 75 THEN D_AGEGRP = "GROUP3";
    ELSE IF D_AGE > 75 THEN D_AGEGRP = "GROUP4";
    ELSE D_AGEGRP = "MISSING";

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  CASEVERSION = "Safety Report Version Number."*/
/*		  I_F_CODE = "Code for initial or follow-up status of report, as reported by manufacturer. CODE MEANING_TEXT I Initial F Follow-up"*/
/*		  EVENT_DT = "Date the adverse event occurred or began. (YYYYMMDD format)"*/
/*		  MFR_DT = "Date manufacturer first received initial information."*/
/*		  INIT_FDA_DT = "Date FDA received first version (Initial) of Case (YYYYMMDD format)"*/
/*		  FDA_DT = "Date FDA received Case. In subsequent versions of a case, the latest manufacturer received date will be provided (YYYYMMDD format)."*/
/*		  REPT_COD = "Code for the type of report submitted. EXP Expedited (15-Day) PER Periodic (Non-Expedited) DIR Direct 5DAY 5-Day 30DAY 30-Day"*/
/*		  AUTH_NUM = "Regulatory Authority’s case report number, when available."*/
/*		  MFR_NUM = "Manufacturer's unique report identifier."*/
/*		  MFR_SNDR = "Coded name of manufacturer sending report; if not found, then verbatim name of organization sending report."*/
/*		  LIT_REF = "Literature Reference information, when available; populated with last 500 characters if >500 characters are available."*/
/*		  AGE = "Numeric value of patient's age at event."*/
/*		  AGE_COD = "Unit abbreviation for patient's age (See table below) CODE MEANING_TEXT DEC DECADE YR YEAR MON MONTH WK WEEK DY DAY HR HOUR"*/
/*		  AGE_GRP = "Patient Age Group code as follows, when available: CODE MEANING_TEXT N Neonate I Infant C Child T Adolescent A Adult E Elderly"*/
/*		  SEX = "Code for patient's sex (See table below) CODE MEANING_TEXT ---- ------------ UNK Unknown M Male F Female"*/
/*		  E_SUB = "Whether (Y/N) this report was submitted under the electronic submissions procedure for manufacturers."*/
/*		  WT = "Numeric value of patient's weight."*/
/*		  WT_COD = "Unit abbreviation for patient's weight (See table below) CODE MEANING_TEXT ---- ------------ KG Kilograms LBS Pounds GMS Grams"*/
/*		  REPT_DT = "Date report was sent (YYYYMMDD format). If a complete date is not available, a partial date is provided."*/
/*		  TO_MFR = "Whether (Y/N) voluntary reporter also notified manufacturer (blank for manufacturer reports)."*/
/*		  OCCP_COD = "Abbreviation for the reporter's type of occupation. MD Physician PH Pharmacist OT Other health-professional LW Lawyer CN Consumer"*/
/*		  REPORTER_COUNTRY = "The country of the reporter in the latest version of a case:"*/
/*		  OCCR_COUNTRY = "The country where the event occurred."*/
/*		  D_AGE = "Derived age in years"*/
/*		  D_WT = "Derived weight in kilograms"*/
/*	;*/
RUN;

DATA Afinal23.drug23_d;
	SET ARAW23.Drug23q4;

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  DRUG_SEQ = "Unique number for identifying a drug for a Case."*/
/*		  ROLE_COD = "Code for drug's reported role in event(See table below)"*/
/*		  DRUGNAME = "Name of medicinal product."*/
/*		  PROD_AI = "Product Active Ingredient, when available."*/
/*		  VAL_VBM = "Code for source of DRUGNAME"*/
/*		  ROUTE = "The route of drug administration"*/
/*		  DOSE_VBM = "Verbatim text for dose, frequency, and route, exactly as entered on report."*/
/*		  CUM_DOSE_CHR = "Cumulative dose to first reaction"*/
/*		  CUM_DOSE_UNIT = "Cumulative dose to first reaction unit CODE Meaning"*/
/*		  DECHAL = "Dechallenge code, indicating if reaction abated when drug therapy was stopped"*/
/*		  RECHAL = "Rechallenge code, indicating if reaction recurred when drug therapy was restarted"*/
/*		  LOT_NUM = "Expiration date of the drug. (YYYYMMDD format)"*/
/*		  EXP_DT = "Lot number of the drug (as reported)."*/
/*		  NDA_NUM = "NDA number (numeric only)"*/
/*		  DOSE_AMT = "Amount of drug reported"*/
/*		  DOSE_UNI = "Unit of drug dose"*/
/*		  DOSE_FORM = "Form of dose reported"*/
/*		  DOSE_FREQ = "Code for Frequency"*/
/*	;*/
RUN;

DATA Afinal23.indi23_d;
	SET ARAW23.Indi23q4;

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  INDI_DRUG_SEQ = "Drug sequence number for identifying a drug for a Case."*/
/*		  INDI_PT = "Preferred Term-level medical terminology describing the Indication for use."*/
/*	;*/
RUN;

DATA Afinal23.outc23_d;
	SET ARAW23.Outc23q4;

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  OUTC_COD = "Code for a patient outcome."*/
/*	;*/
RUN;

DATA Afinal23.reac23_d;
	SET ARAW23.Reac23q4;

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  PT = "Preferred term to describe the event"*/
/*		  DRUG_REC_ACT = "Drug Recur Action data."*/
/*	;*/
RUN;

DATA Afinal23.rpsr23_d;
	SET ARAW23.Rpsr23q4;

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  RPSR_COD = "Code for the source of the report."*/
/*	;*/
RUN;

DATA Afinal23.ther23_d(drop=TEMP_DUR);
    SET ARAW23.Ther23q4;

    /* Initialize variables */
    TEMP_DUR = .;
    DER_DUR  = .;

    /*Derived missing start and end date*/
    IF DUR_COD = "" THEN DO;
        IF START_DT = . THEN START_DT = END_DT;
        ELSE IF END_DT = . THEN END_DT = START_DT;
    END;

    /*If Duration and Duration Code is missing but start and end date not missing*/
    IF DUR_COD = "" AND DUR = . THEN DO;
        TEMP_DUR = (END_DT - START_DT);
    END;

    /*If Temp Duration is missing*/
    IF TEMP_DUR = . THEN DO;
        TEMP_DUR = DUR;
        DER_DUR  = DUR;
    END;

    /* If DUR is missing but we have start and end date */
    IF DUR = . THEN DO;
        TEMP_DUR = ABS((END_DT - START_DT) + 1);
        DER_DUR  = TEMP_DUR;
    END;

    /* Temp duration, Duration, and end date is missing */
    IF DUR_COD = "" AND DUR = . AND END_DT = . THEN DO;
        IF START_DT ^= . AND TEMP_DUR ^= . THEN END_DT = START_DT + TEMP_DUR - 1;
        ELSE IF START_DT ^= . AND DUR ^= . THEN END_DT = START_DT + DUR - 1;
    END;

    /* Temp duration, Duration, and start date is missing */
    IF DUR_COD = "" AND DUR = . AND START_DT = . THEN DO;
        IF END_DT ^= . AND TEMP_DUR ^= . THEN START_DT = END_DT - TEMP_DUR + 1;
        ELSE IF END_DT ^= . AND DUR ^= . THEN START_DT = END_DT - DUR + 1;
    END;

    /* Derive if Duration is 0, add 1 day */
    IF DUR = 0 AND START_DT ^= . THEN DO;
        END_DT   = START_DT + 1;
        TEMP_DUR = 1;
        DER_DUR  = 1;
    END;

    /* Duration derivation based on DUR_COD and DUR */
    IF DUR_COD = "DAYS"    THEN DER_DUR = FLOOR(DUR / 365);
    ELSE IF DUR_COD = "HOURS"   THEN DER_DUR = FLOOR(DUR / 8760);
    ELSE IF DUR_COD = "MONTHS"  THEN DER_DUR = FLOOR(DUR / 12);
    ELSE IF DUR_COD = "WEEKS"   THEN DER_DUR = FLOOR(DUR / 52);
    ELSE IF DUR_COD = "MINUTES" THEN DER_DUR = FLOOR(DUR / 525600);
    ELSE IF DUR_COD = "SECONDS" THEN DER_DUR = FLOOR(DUR / 31536000);
    ELSE IF DUR_COD = "YEARS"   THEN DER_DUR = FLOOR(DUR);

	/* LABELS */
/*	LABEL PRIMARYID = "Unique number for identifying a FAERS report."*/
/*		  CASEID = "Number for identifying a FAERS case."*/
/*		  DSG_DRUG_SEQ = "Drug sequence number for identifying a drug for a Case."*/
/*		  START_DT = "Date the therapy was started (or re-started) for this drug"*/
/*		  END_DT = "A date therapy was stopped for this drug."*/
/*		  DUR = "Numeric value of the duration (length) of therapy"*/
/*		  DUR_COD = "Units for therapy duration: YR Years MON Months WK Weeks DAY Days HR Hours MIN Minutes SEC Seconds"*/
/*	;*/

RUN;
