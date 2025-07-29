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

PROC FORMAT;
	value $yesno
		"Y" = "Yes"
		"N" = "No"
	;
RUN;

PROC FORMAT;
	value $i_f_cod
		"I" = "Initial"
		"F" = "Follow-up"
	;
RUN;

PROC FORMAT;
	value $rept_cod
		"EXP" = "Expedited"
		"PER" = "Periodic"
		"DIR" = "Direct"
		"5DAY" = "5 Day"
		"30DAY" = "30 Day"
	;
RUN;

PROC FORMAT;
	value $age_cod
		"DEC" = "Decade"
		"YR" = "Year"
		"MON" = "Month"
		"WK" = "Week"
		"DY" = "Day"
		"HR" = "Hour"
	;
RUN;

PROC FORMAT;
	value $age_grp
		"N" = "Neonate"
		"I" = "Infant"
		"C" = "Child"
		"T" = "Adolescent"
		"A" = "Adult"
		"E" = "Elderly"
	;
RUN;

PROC FORMAT;
	value $sex
		"UNK" = "Unknown"
		"M" = "Male"
		"F" = "Female"
	;
RUN;

PROC FORMAT;
	value $wt_cod
		"KG" = "Kilograms"
		"LBS" = "Pounds"
		"GMS" = "Grams"
	;
RUN;

PROC FORMAT;
	value $occp_cod
		"MD" = "Physician"
		"PH" = "Pharmacist"
		"OT" = "Other Health Professional"
		"LW" = "Lawyer"
		"CN" = "Consumer"
		"HP" = "Health Professional"
	;
RUN;

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
    ELSE D_AGEGRP = "MISSIN";

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  CASEVERS = "Safety Report Version Number."
		  I_F_CODE = "Code for initial or follow-up status of report, as reported by manufacturer."
		  EVENT_DT = "Date the adverse event occurred or began. (YYYYMMDD format)"
		  MFR_DT = "Date manufacturer first received initial information."
		  INIT_FDA = "Date FDA received first version (Initial) of Case (YYYYMMDD format)"
		  FDA_DT = "Date FDA received Case(YYYYMMDD format)."
		  REPT_COD = "Code for the type of report submitted"
		  AUTH_NUM = "Regulatory Authority’s case report number."
		  MFR_NUM = "Manufacturer's unique report identifier."
		  MFR_SNDR = "Coded name of manufacturer sending report."
		  LIT_REF = "Literature Reference information."
		  AGE = "Numeric value of patient's age at event."
		  AGE_COD = "Unit abbreviation for patient's age"
		  AGE_GRP = "Patient Age Group code"
		  SEX = "Code for patient's sex"
		  E_SUB = "Whether (Y/N) this report was submitted under the electronic submissions procedure for manufacturers."
		  WT = "Numeric value of patient's weight."
		  WT_COD = "Unit abbreviation for patient's weight."
		  REPT_DT = "Date report was sent (YYYYMMDD format)."
		  TO_MFR = "Whether (Y/N) voluntary reporter also notified manufacturer (blank for manufacturer reports)."
		  OCCP_COD = "Reporter's type of occupation."
		  REPORTER = "The country of the reporter in the latest version of a case."
		  OCCR_COU = "The country where the event occurred."
		  D_AGE = "Derived age in years."
		  D_WT = "Derived weight in kilograms."
		  D_AGEGRP = "Derived age group."
	;

	format I_F_CODE $i_f_cod.;
	format REPT_COD $rept_cod.;
	format AGE_COD $age_cod.;
	format AGE_GRP $age_grp.;
	format SEX $sex.;
	format WT_COD $wt_cod.;
	format OCCP_COD $occp_cod.;
	format TO_MFR $yesno.;
	format E_SUB $yesno.;
RUN;


PROC FORMAT;
    VALUE $role_cod
        'PS' = 'Primary Suspect Drug'
        'SS' = 'Secondary Suspect Drug'
        'C'  = 'Concomitant'
        'I'  = 'Interacting';
RUN;

PROC FORMAT;
    VALUE val_vbm
        1 = 'Validated trade name used'
        2 = 'Verbatim name used';
RUN;

PROC FORMAT;
    VALUE $drug_unit
        'KG'     = 'Kilogram(s)'
        'GM'     = 'Gram(s)'
        'MG'     = 'Milligram(s)'
        'UG'     = 'Microgram(s) (µg)'
        'NG'     = 'Nanogram(s)'
        'PG'     = 'Picogram(s)'
        'MG/KG'  = 'Milligram(s)/Kilogram'
        'UG/KG'  = 'Microgram(s)/Kilogram (µG/KG)'
        'MG/M**2'= 'Milligram(s)/Sq. Meter'
        'UG/M**2'= 'Microgram(s)/Sq. Meter (µG/M**2)'
        'L'      = 'Litre(s)'
        'ML'     = 'Millilitre(s)'
        'UL'     = 'Microlitre(s) (µL)'
        'BQ'     = 'Becquerel(s)'
        'GBQ'    = 'Gigabecquerel(s)'
        'MBQ'    = 'Megabecquerel(s)'
        'KBQ'    = 'Kilobecquerel(s)'
        'CI'     = 'Curie(s)'
        'MCI'    = 'Millicurie(s)'
        'UCI'    = 'Microcurie(s) (µCI)'
        'NCI'    = 'Nanocurie(s)'
        'MOL'    = 'Mole(s)'
        'MMOL'   = 'Millimole(s)'
        'UMOL'   = 'Micromole(s)'
        'IU'     = 'International Unit(s)'
        'KIU'    = 'International Unit*(1000s)'
        'MIU'    = 'International Unit*(1,000,000s)'
        'IU/KG'  = 'IU/Kilogram'
        'MEQ'    = 'Milliequivalent(s)'
        'PCT'    = 'Percent (%)'
        'GTT'    = 'Drop(s)'
        'DF'     = 'Dosage Form'
    ;
RUN;

PROC FORMAT;
    VALUE $chal
        'Y' = 'Positive dechallenge'
        'N' = 'Negative dechallenge'
        'U' = 'Unknown'
        'D' = 'Does not apply';
RUN;

PROC FORMAT;
    VALUE $freq
        '1X'  = 'Once or one time'
        'BID' = 'Twice a day'
        'BIW' = 'Twice a week'
        'HS'  = 'At bedtime'
        'PRN' = 'As needed'
        'Q12H'= 'Every 12 hours'
        'Q2H' = 'Every 2 hours'
        'Q3H' = 'Every 3 hours'
        'Q3W' = 'Every 3 weeks'
        'Q4H' = 'Every 4 hours'
        'Q5H' = 'Every 5 hours'
        'Q6H' = 'Every 6 hours'
        'Q8H' = 'Every 8 hours'
        'QD'  = 'Daily'
        'QH'  = 'Every hour'
        'QID' = '4 times a day'
        'QM'  = 'Monthly'
        'QOD' = 'Every other day'
        'QOW' = 'Every other week'
        'QW'  = 'Every week'
        'TID' = '3 times a day'
        'TIW' = '3 times a week'
        'UNK' = 'Unknown';
RUN;

DATA Afinal23.drug23_d;
	SET ARAW23.Drug23q4;

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  DRUG_SEQ = "Unique number for identifying a drug for a Case."
		  ROLE_COD = "Code for drug's reported role in event."
		  DRUGNAME = "Name of medicinal product."
		  PROD_AI = "Product Active Ingredient."
		  VAL_VBM = "Code for source of DRUGNAME."
		  ROUTE = "The route of drug administration"
		  DOSE_VBM = "Verbatim text for dose, frequency, and route, exactly as entered on report."
		  CUM_DOSE = "Cumulative dose to first reaction"
		  VAR11 = "Cumulative dose to first reaction unit CODE Meaning"
		  DECHAL = "Dechallenge code, indicating if reaction abated when drug therapy was stopped"
		  RECHAL = "Rechallenge code, indicating if reaction recurred when drug therapy was restarted"
		  LOT_NUM = "Expiration date of the drug. (YYYYMMDD format)"
		  EXP_DT = "Lot number of the drug (as reported)."
		  NDA_NUM = "NDA number."
		  DOSE_AMT = "Amount of drug reported."
		  DOSE_UNI = "Unit of drug dose."
		  DOSE_FOR = "Form of dose reported."
		  DOSE_FRE = "Code for Frequency."
	;

	format ROLE_COD $role_cod.;
	format VAL_VBM val_vbm.;
	format VAR11 $drug_unit.;
	format DOSE_UNI $drug_unit.;
	format DECHAL $chal.;
	format RECHAL $chal.;
	format DOSE_FRE $freq.;
RUN;


DATA Afinal23.indi23_d;
	SET ARAW23.Indi23q4;

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  INDI_DRU = "Drug sequence number for identifying a drug for a Case."
		  INDI_PT = "Preferred Term-level medical terminology describing the Indication for use."
	;
RUN;


PROC FORMAT;
    VALUE $outc_cod
        'DE' = 'Death'
        'LT' = 'Life-Threatening'
        'HO' = 'Hospitalization - Initial or Prolonged'
        'DS' = 'Disability'
        'CA' = 'Congenital Anomaly'
        'RI' = 'Required Intervention to Prevent Permanent Impairment/Damage'
        'OT' = 'Other Serious (Important Medical Event)';
RUN;

DATA Afinal23.outc23_d;
	SET ARAW23.Outc23q4;

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  OUTC_COD = "Code for a patient outcome."
	;

	format OUTC_COD $outc_cod.;
RUN;


DATA Afinal23.reac23_d;
	SET ARAW23.Reac23q4;

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  PT = "Preferred term to describe the event"
		  DRUG_REC = "Drug Recur Action data."
	;
RUN;


PROC FORMAT;
    VALUE $rpsr_cod
        'FGN' = 'Foreign'
        'SDY' = 'Study'
        'LIT' = 'Literature'
        'CSM' = 'Consumer'
        'HP'  = 'Health Professional'
        'UF'  = 'User Facility'
        'CR'  = 'Company Representative'
        'DT'  = 'Distributor'
        'OTH' = 'Other';
RUN;

DATA Afinal23.rpsr23_d;
	SET ARAW23.Rpsr23q4;

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  RPSR_COD = "Code for the source of the report."
	;

	format RPSR_COD $rpsr_cod.
RUN;


PROC FORMAT;
    VALUE $dur_cod
        'YR'  = 'Years'
        'MON' = 'Months'
        'WK'  = 'Weeks'
        'DAY' = 'Days'
        'HR'  = 'Hours'
        'MIN' = 'Minutes'
        'SEC' = 'Seconds';
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

/*	LABELS */
	LABEL PRIMARYI = "Unique number for identifying a FAERS report."
		  CASEID = "Number for identifying a FAERS case."
		  DSG_DRUG = "Drug sequence number for identifying a drug for a Case."
		  START_DT = "Date the therapy was started (or re-started) for this drug"
		  END_DT = "A date therapy was stopped for this drug."
		  DUR = "Numeric value of the duration (length) of therapy."
		  DUR_COD = "Units for therapy duration."
		  DER_DUR = "Derived duration."
	;
	
	format DUR_COD $dur_cod.
RUN;
