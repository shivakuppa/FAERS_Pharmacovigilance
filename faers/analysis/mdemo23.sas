PROC PRINTTO LOG="C:\dev\faers\log\mdemo23.log" NEW;
RUN;

data Dem1;
    length AGEGRPC $8;  /* define length before assigning values */
    set AFinal23.Demo23_d;

    /* Assign derived age group values */
    AGEGRP = D_AGE;
    AGEGRPC = D_AGEGRP;
    output;

    /* Create total row */
    AGEGRP = 1000;
    AGEGRPC = "Total";
    output;

    /* Subset missing D_AGE values */
    where D_AGE ne .;
run;


/*Calculation of big N count derivation (Column header N=XX)*/
PROC SQL;

	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP1 FROM Dem1 WHERE AGEGRPC="GROUP1";
	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP2 FROM Dem1 WHERE AGEGRPC="GROUP2";
	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP3 FROM Dem1 WHERE AGEGRPC="GROUP3";
	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP4 FROM Dem1 WHERE AGEGRPC="GROUP4";
	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP5 FROM Dem1 WHERE AGEGRPC="MISSIN";
	SELECT COUNT (DISTINCT PRIMARYI) INTO: AGEGRP6 FROM Dem1;
	
/*	%PUT &AGEGRP1 &AGEGRP2 &AGEGRP3 &AGEGRP4 &AGEGRP5;*/

QUIT;

/* Gender count excluding missing/empty/0 values for SEX and AGEGRPC */
proc freq data=Dem1;
    tables SEX*AGEGRPC / out=GENDER (drop=percent) sparse;
    where strip(SEX) ne "" and SEX ne "0" and strip(AGEGRPC) ne "" and AGEGRPC ne "0";
run;

/* Report code count */
proc freq data=Dem1;
    tables REPT_COD*AGEGRPC / out=REPORT (drop=percent) sparse;
    where strip(REPT_COD) ne "" and REPT_COD ne "0" and strip(AGEGRPC) ne "" and AGEGRPC ne "0";
run;

/* Occupation code count */
proc freq data=Dem1;
    tables OCCP_COD*AGEGRPC / out=OCCP (drop=percent) sparse;
    where strip(OCCP_COD) ne "" and OCCP_COD ne "0" and strip(AGEGRPC) ne "" and AGEGRPC ne "0";
run;



data GENDER1;
    set Gender;

    /* Assign denominator based on AGEGRPC */
    if AGEGRPC="GROUP1" then DENOM=&AGEGRP1;
    else if AGEGRPC="GROUP2" then DENOM=&AGEGRP2;
    else if AGEGRPC="GROUP3" then DENOM=&AGEGRP3;
    else if AGEGRPC="GROUP4" then DENOM=&AGEGRP4;
	else if AGEGRPC="Total" then DENOM=&AGEGRP5;
    else DENOM=.; /* or assign a total value if you have it */

    /* Calculate percent only if DENOM is not missing */
    if DENOM > 0 then PERCENT=PUT((COUNT/DENOM)*100,7.1);
    else PERCENT=".";

    COUNTPER=COUNT || " (" || STRIP(PERCENT) || ")";

    /* Keep only records where SEX and AGEGRPC are non-missing */
    where SEX ne "" and AGEGRPC ne "";

    drop COUNT DENOM PERCENT;
run;


data REPORT1;
	set REPORT;

	/* Assign denominator based on AGEGRPC */
    if AGEGRPC="GROUP1" then DENOM=&AGEGRP1;
    else if AGEGRPC="GROUP2" then DENOM=&AGEGRP2;
    else if AGEGRPC="GROUP3" then DENOM=&AGEGRP3;
    else if AGEGRPC="GROUP4" then DENOM=&AGEGRP4;
	else if AGEGRPC="Total" then DENOM=&AGEGRP5;
    else DENOM=.; /* or assign a total value if you have it */

    /* Calculate percent only if DENOM is not missing */
    if DENOM > 0 then PERCENT=PUT((COUNT/DENOM)*100,7.1);
    else PERCENT=".";

    COUNTPER=COUNT || " (" || STRIP(PERCENT) || ")";

	where AGEGRPC ne "" and REPT_COD ne "";

    drop COUNT DENOM PERCENT;
run;

data OCCP1;
	set OCCP;

	/* Assign denominator based on AGEGRPC */
    if AGEGRPC="GROUP1" then DENOM=&AGEGRP1;
    else if AGEGRPC="GROUP2" then DENOM=&AGEGRP2;
    else if AGEGRPC="GROUP3" then DENOM=&AGEGRP3;
    else if AGEGRPC="GROUP4" then DENOM=&AGEGRP4;
	else if AGEGRPC="Total" then DENOM=&AGEGRP5;
    else DENOM=.; /* or assign a total value if you have it */

    /* Calculate percent only if DENOM is not missing */
    if DENOM > 0 then PERCENT=PUT((COUNT/DENOM)*100,7.1);
    else PERCENT=".";

    COUNTPER=COUNT || " (" || STRIP(PERCENT) || ")";

	where AGEGRPC ne "" and OCCP_COD ne "";

    drop COUNT DENOM PERCENT;
run;

/*Restructure dataset such that age ageoups and their totals appears as columns and gender code as roles*/
PROC SORT Data=GENDER1 Out=Gender2;
	BY SEX;
RUN;

PROC SORT Data=REPORT1 Out=REPORT2;
	BY REPT_COD;
RUN;

PROC SORT Data=OCCP1 Out=OCCP2;
	BY OCCP_COD;
RUN;

PROC TRANSPOSE Data=Gender2 Out=Gender3 (DROP=_NAME_);
	BY SEX;
	ID AGEGRPC;
	VAR COUNTPER;
RUN;

PROC TRANSPOSE Data=REPORT2 Out=REPORT3 (DROP=_NAME_);
	BY REPT_COD;
	ID AGEGRPC;
	VAR COUNTPER;
RUN;

PROC TRANSPOSE Data=OCCP2 Out=OCCP3 (DROP=_NAME_);
	BY OCCP_COD;
	ID AGEGRPC;
	VAR COUNTPER;
RUN;


/*Calculating Age Statistics*/
PROC MEANS Data=Dem1;
	CLASS AGEGRPC;
	VAR D_AGE;
	OUTPUT OUT= ASTATS (DROP=_TYPE_ _FREQ_) 
	N=_N
	MEAN=_MEAN
	STD=_STD
	MEDIAN=_MEDIAN
	MIN=_MIN
	MAX=_MAX;
RUN;

PROC MEANS Data=Dem1;
	CLASS AGEGRPC;
	VAR D_WT;
	OUTPUT OUT= WSTATS (DROP=_TYPE_ _FREQ_) 
	N=_N
	MEAN=_MEAN
	STD=_STD
	MEDIAN=_MEDIAN
	MIN=_MIN
	MAX=_MAX;
RUN;

DATA ASTATS1;
	LENGTH N MEAN MEDIAN GM MIN MAX STD RANGE $40.;
	set ASTATS;
	N=COMPRESS(PUT(_N,5.));
	MEAN=COMPRESS(PUT(_MEAN,5.2));
	MEDIAN=COMPRESS(PUT(_MEDIAN,5.2));
	GM=COMPRESS(PUT(GEOMEAN(_MEAN),5.2));
	MIN=COMPRESS(PUT(_MIN,5.2));
	MAX=COMPRESS(PUT(_MAX,5.2));
	STD=COMPRESS(PUT(_STD,5.2));
	RANGE=COMPRESS(CATX("-",_MIN,_MAX));

	IF AGEGRPC NE "";
	DROP _N _MEAN _MEDIAN _GM _MIN _MAX _STD _RANGE;
RUN;

DATA WSTATS1;
	LENGTH N MEAN MEDIAN GM MIN MAX STD RANGE $40.;
	set WSTATS;
	N=COMPRESS(PUT(_N,5.));
	MEAN=COMPRESS(PUT(_MEAN,5.2));
	MEDIAN=COMPRESS(PUT(_MEDIAN,5.2));
	GM=COMPRESS(PUT(GEOMEAN(_MEAN),5.2));
	MIN=COMPRESS(PUT(_MIN,5.2));
	MAX=COMPRESS(PUT(_MAX,5.2));
	STD=COMPRESS(PUT(_STD,5.2));
	RANGE=COMPRESS(CATX("-",_MIN,_MAX));

	IF AGEGRPC NE "";
	DROP _N _MEAN _MEDIAN _GM _MIN _MAX _STD _RANGE;
RUN;

/*Restructure dataset such that age ageoups and their totals appears as columns and age as roles*/
PROC SORT Data=ASTATS1 Out=ASTATS2;
	BY AGEGRPC;
RUN;

PROC SORT Data=WSTATS1 Out=WSTATS2;
	BY AGEGRPC;
RUN;

PROC TRANSPOSE Data=ASTATS2 Out=ASTATS3 (DROP=_LABEL_);
	ID AGEGRPC;
	VAR N MEAN MEDIAN GM MIN MAX STD RANGE;
RUN;

PROC TRANSPOSE Data=WSTATS2 Out=WSTATS3 (DROP=_LABEL_);
	ID AGEGRPC;
	VAR N MEAN MEDIAN GM MIN MAX STD RANGE;
RUN;


PROC SQL;
    CREATE TABLE Gender4 AS
    SELECT 
        PUT(SEX,$25.) AS STAT LENGTH=25,
        GROUP1 LENGTH=25,
        GROUP2 LENGTH=25,
        GROUP3 LENGTH=25,
        GROUP4 LENGTH=25,
        TOTAL LENGTH=25,
        "GNDR_COD (GENDER)" AS CAT LENGTH=25
    FROM Gender3
    ORDER BY
        CASE WHEN SEX='M' THEN 1
             WHEN SEX='F' THEN 2
             WHEN SEX='U' THEN 3
             ELSE 0 END;

    CREATE TABLE REPORT4 AS
    SELECT 
        PUT(REPT_COD,$25.) AS STAT LENGTH=25,
        GROUP1 LENGTH=25,
        GROUP2 LENGTH=25,
        GROUP3 LENGTH=25,
        GROUP4 LENGTH=25,
        TOTAL LENGTH=25,
        "REPT_COD (REPORT)" AS CAT LENGTH=25
    FROM REPORT3
    ORDER BY
        CASE WHEN REPT_COD='EXP' THEN 1
             WHEN REPT_COD='PER' THEN 2
             WHEN REPT_COD='DIR' THEN 3
             WHEN REPT_COD='5DAY' THEN 4
             WHEN REPT_COD='30DAY' THEN 5
             ELSE 0 END;

    CREATE TABLE OCCP4 AS
    SELECT 
        PUT(OCCP_COD,$25.) AS STAT LENGTH=25,
        GROUP1 LENGTH=25,
        GROUP2 LENGTH=25,
        GROUP3 LENGTH=25,
        GROUP4 LENGTH=25,
        TOTAL LENGTH=25,
        "OCCP_COD (OCCUPATION)" AS CAT LENGTH=25
    FROM OCCP3
    ORDER BY
        CASE WHEN OCCP_COD='MD' THEN 1
             WHEN OCCP_COD='PH' THEN 2
             WHEN OCCP_COD='LW' THEN 3
             WHEN OCCP_COD='CN' THEN 4
             ELSE 0 END;

    CREATE TABLE ASTATS4 AS
    SELECT 
        PUT(_NAME_,$25.) AS STAT LENGTH=25,
        GROUP1 LENGTH=25,
        GROUP2 LENGTH=25,
        GROUP3 LENGTH=25,
        GROUP4 LENGTH=25,
        TOTAL LENGTH=25,
        "D_AGE (YEARS)" AS CAT LENGTH=25
    FROM ASTATS3
    ORDER BY
        CASE WHEN _NAME_='N' THEN 1
             WHEN _NAME_='MEAN' THEN 2
             WHEN _NAME_='MEDIAN' THEN 3
             WHEN _NAME_='GM' THEN 4
             WHEN _NAME_='MIN' THEN 5
             WHEN _NAME_='MAX' THEN 6
             WHEN _NAME_='RANGE' THEN 7
             WHEN _NAME_='STD' THEN 8
             ELSE 0 END;

    CREATE TABLE WSTATS4 AS
    SELECT 
        PUT(_NAME_,$25.) AS STAT LENGTH=25,
        GROUP1 LENGTH=25,
        GROUP2 LENGTH=25,
        GROUP3 LENGTH=25,
        GROUP4 LENGTH=25,
        TOTAL LENGTH=25,
        "D_WT (KILOGRAMS)" AS CAT LENGTH=25
    FROM WSTATS3
    ORDER BY
        CASE WHEN _NAME_='N' THEN 1
             WHEN _NAME_='MEAN' THEN 2
             WHEN _NAME_='MEDIAN' THEN 3
             WHEN _NAME_='GM' THEN 4
             WHEN _NAME_='MIN' THEN 5
             WHEN _NAME_='MAX' THEN 6
             WHEN _NAME_='RANGE' THEN 7
             WHEN _NAME_='STD' THEN 8
             ELSE 0 END;
QUIT;




/* COMBINE EVERYTHING INTO WORK.FINAL */
DATA WORK.FINAL;

    /* Gender4 */
    SET WORK.GENDER4
        WORK.REPORT4
        WORK.OCCP4
        WORK.ASTATS4
        WORK.WSTATS4
	;
RUN;

DATA AFINAL23.demo_table;
    SET WORK.FINAL;
RUN;

PROC PRINTTO;
RUN;
