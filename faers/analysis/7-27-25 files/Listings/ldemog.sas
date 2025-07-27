/* *************************************************************************
* PROGRAM : ldemog.sas
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

/*OPTIONS OBS=100;*/

ODS PDF FILE="C:\dev\faers\tlg\Demo1Listings.pdf"; 

/*OPTIONS OBS=1000;*/

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
