PROC SQL;
    CREATE TABLE DRUG AS
    SELECT 
        a.D_AGEGRP,
        b.ROLE_COD,
        b.DECHAL,
        b.RECHAL,
        b.ROUTE,
        /* New column based on VAL_VBM */
        CASE 
            WHEN b.VAL_VBM = 1 THEN "Validated Trade Name"
            WHEN b.VAL_VBM = 2 THEN "Verbatim Name Used"
            ELSE ""
        END AS VAL_VBM LENGTH=25
    FROM Afinal23.demo23_d AS a
    INNER JOIN Afinal23.drug23_d AS b
        ON a.PRIMARYI = b.PRIMARYI
       AND a.CASEID   = b.CASEID
    WHERE a.D_AGEGRP NE "MISSIN"
;
QUIT;


PROC SQL;
    CREATE TABLE route AS
    SELECT 
        ROUTE AS STAT,
		"ROUTE    " AS CAT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        /* Total is sum of the four counts */
        COUNT(ROUTE) AS TOTAL
    FROM DRUG
    GROUP BY ROUTE
	HAVING ROUTE NE ""
    ORDER BY TOTAL DESC;
QUIT;

DATA route_fmt;
    SET route;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;


PROC SQL;
    CREATE TABLE dechal AS
    SELECT 
        DECHAL AS STAT,
		"DECHALLENGE    " AS CAT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        /* Total is sum of the four counts */
        COUNT(DECHAL) AS TOTAL
    FROM DRUG
    GROUP BY DECHAL
	HAVING DECHAL NE ""
    ORDER BY 
        CASE 
            WHEN DECHAL = "Y" THEN 1
            WHEN DECHAL = "N" THEN 2
            WHEN DECHAL = "U" THEN 3
            WHEN DECHAL = "D" THEN 4
            ELSE 5
	END;
QUIT;

DATA dechal_fmt;
    SET dechal;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;


PROC SQL;
    CREATE TABLE rechal AS
    SELECT 
        rechal AS STAT,
		"RECHALLENGE    " AS CAT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        /* Total is sum of the four counts */
        COUNT(RECHAL) AS TOTAL
    FROM DRUG
    GROUP BY RECHAL
	HAVING RECHAL NE ""
    ORDER BY 
        CASE 
            WHEN RECHAL = "Y" THEN 1
            WHEN RECHAL = "N" THEN 2
            WHEN RECHAL = "U" THEN 3
            WHEN RECHAL = "D" THEN 4
            ELSE 5
	END;
QUIT;

DATA rechal_fmt;
    SET rechal;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;


PROC SQL;
    CREATE TABLE role_cod AS
    SELECT 
        ROLE_COD AS STAT,
		"ROLE           " AS CAT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        /* Total is sum of the four counts */
        COUNT(ROLE_COD) AS TOTAL
    FROM DRUG
    GROUP BY ROLE_COD
	HAVING ROLE_COD NE ""
    ORDER BY 
        CASE 
            WHEN ROLE_COD = "PS" THEN 1
            WHEN ROLE_COD = "SS" THEN 2
            WHEN ROLE_COD = "C" THEN 3
            WHEN ROLE_COD = "I" THEN 4
            ELSE 5
	END;
QUIT;

DATA role_cod_fmt;
    SET role_cod;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;


PROC SQL;
    CREATE TABLE val_vbm AS
    SELECT 
        VAL_VBM AS STAT,
        "VALUE VERBATIM" AS CAT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        COUNT(VAL_VBM) AS TOTAL
    FROM DRUG
    GROUP BY VAL_VBM
    ORDER BY 
        CASE 
            WHEN VAL_VBM = "Validated Trade Name" THEN 1
            WHEN VAL_VBM = "Verbatim Name Used" THEN 2
            ELSE 3
	END;
QUIT;

DATA val_vbm_fmt;
    SET val_vbm;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;


DATA WORK.FINAL;
    SET 
        WORK.role_cod_fmt
        WORK.val_vbm_fmt
        WORK.dechal_fmt
        WORK.rechal_fmt
        WORK.route_fmt
    ;
RUN;

DATA AFINAL23.drug_table;
    SET WORK.FINAL;
RUN;
