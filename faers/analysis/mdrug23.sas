PROC SQL;
    CREATE TABLE DRUG AS
    SELECT a.D_AGEGRP,
           b.ROLE_COD,
		   b.VAL_VBM,
		   b.DECHAL,
		   b.RECHAL,
		   b.ROUTE
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

DATA chal_master;
    LENGTH chal $1;
    INPUT chal $;
    DATALINES;
Y
N
U
D
;
RUN;

PROC SQL;
    CREATE TABLE dechal AS
    SELECT m.chal AS STAT,
		   "DECHAL   " AS CAT,
           COALESCE(c.N1,0) AS N1,
           COALESCE(c.N2,0) AS N2,
           COALESCE(c.N3,0) AS N3,
           COALESCE(c.N4,0) AS N4,
           CALCULATED N1 + CALCULATED N2 + CALCULATED N3 + CALCULATED N4 AS TOTAL
    FROM chal_master AS m
    LEFT JOIN DRUG AS c
        ON m.chal = c.DECHAL
    ORDER BY 
        CASE 
            WHEN m.chal = "Y" THEN 1
            WHEN m.chal = "N" THEN 2
            WHEN m.chal = "U" THEN 3
            WHEN m.chal = "D" THEN 4
            ELSE 5
	END
	;
QUIT;

/* Step 4: Format counts into N (Pct%) columns */
DATA dechal_fmt;
    SET dechal;

    IF TOTAL > 0 THEN DO;
        GROUP1 = CATX(' ', N1, '(' || PUT((N1/TOTAL)*100, 5.1) || '%)');
        GROUP2 = CATX(' ', N2, '(' || PUT((N2/TOTAL)*100, 5.1) || '%)');
        GROUP3 = CATX(' ', N3, '(' || PUT((N3/TOTAL)*100, 5.1) || '%)');
        GROUP4 = CATX(' ', N4, '(' || PUT((N4/TOTAL)*100, 5.1) || '%)');
    END;
    ELSE DO;
        GROUP1 = '0 (0.0%)';
        GROUP2 = '0 (0.0%)';
        GROUP3 = '0 (0.0%)';
        GROUP4 = '0 (0.0%)';
    END;

    DROP N1 N2 N3 N4;
RUN;
