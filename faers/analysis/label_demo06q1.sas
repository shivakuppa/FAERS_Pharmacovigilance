/* *************************************************************************
* PROGRAM : label_demo06q1
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/24/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

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

OPTIONS OBS=100;

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

ODS PDF FILE="C:\dev\faers\tlg\Demo1Listings.pdf"; 

OPTIONS OBS=1000;

%let name=Lajeeth Thangavel;

PROC PRINT DATA=Demo1 NOOBS;
	/*label I_F_COD = "Intitial/Followup status code (I/F)";*/
	var ISR I_F_COD EVENT_DT MFR_DT REPT_COD AGE AGE_COD D_AGE GNDR_COD D_AGEGRP
	WT WT_COD D_WT REPT_DT OCCP_COD DEATH_DT COUNTRY;

	where AGE^=. AND GNDR_COD^="";

	title "ADVERSE EVENT REPORTING SYSTEM (AERS)";
	title2 "Demographic Listings";
	footnote "&sysdate. &systime. Author=&name.";
run;

ODS PDF CLOSE;

PROC FREQ DATA=Demo1 ;
	table AGE;
run;
