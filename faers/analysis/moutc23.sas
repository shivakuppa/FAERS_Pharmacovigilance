/* Step 1: Master reference list of all possible OUTC_COD values */
DATA outc_master;
    LENGTH OUTC_COD $3;
    INPUT OUTC_COD $;
    DATALINES;
DE
LT
HO
DS
CA
RI
OT
;
RUN;

/* Step 2: Join DEMO + OUTC and create count table */
PROC SQL;
    CREATE TABLE OUTC_counts AS
    SELECT 
        b.OUTC_COD,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4
    FROM Afinal23.demo23_d AS a
    INNER JOIN Afinal23.outc23_d AS b
        ON a.PRIMARYI = b.PRIMARYI
       AND a.CASEID   = b.CASEID
    WHERE a.D_AGEGRP NE "MISSIN"
    GROUP BY b.OUTC_COD
    ;
QUIT;

/* Step 3: Left join to master to keep all values */
PROC SQL;
    CREATE TABLE OUTC_complete AS
    SELECT m.OUTC_COD,
           COALESCE(c.N1,0) AS N1,
           COALESCE(c.N2,0) AS N2,
           COALESCE(c.N3,0) AS N3,
           COALESCE(c.N4,0) AS N4,
           CALCULATED N1 + CALCULATED N2 + CALCULATED N3 + CALCULATED N4 AS TOTAL
    FROM OUTC_master AS m
    LEFT JOIN OUTC_counts AS c
        ON m.OUTC_COD = c.OUTC_COD
    ORDER BY 
        CASE 
            WHEN m.OUTC_COD = "DE" THEN 1
            WHEN m.OUTC_COD = "LT" THEN 2
            WHEN m.OUTC_COD = "HO" THEN 3
            WHEN m.OUTC_COD = "DS" THEN 4
            WHEN m.OUTC_COD = "CA"  THEN 5
            WHEN m.OUTC_COD = "RI"  THEN 6
            WHEN m.OUTC_COD = "OT"  THEN 7
            ELSE 8
	END
	;
QUIT;

/* Step 4: Format counts into N (Pct%) columns */
DATA OUTC_final;
    SET OUTC_complete;

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
