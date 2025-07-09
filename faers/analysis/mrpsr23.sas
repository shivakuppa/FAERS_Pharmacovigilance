/* Step 1: Master reference list of all possible RPSR_COD values */
DATA rpsr_master;
    LENGTH RPSR_COD $3;
    INPUT RPSR_COD $;
    DATALINES;
FGN
SDY
LIT
CSM
HP
UF
CR
DT
OTH
;
RUN;

/* Step 2: Join DEMO + RPSR and create count table */
PROC SQL;
    CREATE TABLE rpsr_counts AS
    SELECT 
        b.RPSR_COD,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN a.D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4
    FROM Afinal23.demo23_d AS a
    INNER JOIN Afinal23.rpsr23_d AS b
        ON a.PRIMARYI = b.PRIMARYI
       AND a.CASEID   = b.CASEID
    WHERE a.D_AGEGRP NE "MISSIN"
    GROUP BY b.RPSR_COD
    ;
QUIT;

/* Step 3: Left join to master to keep all values */
PROC SQL;
    CREATE TABLE rpsr_complete AS
    SELECT m.RPSR_COD,
           COALESCE(c.N1,0) AS N1,
           COALESCE(c.N2,0) AS N2,
           COALESCE(c.N3,0) AS N3,
           COALESCE(c.N4,0) AS N4,
           CALCULATED N1 + CALCULATED N2 + CALCULATED N3 + CALCULATED N4 AS TOTAL
    FROM rpsr_master AS m
    LEFT JOIN rpsr_counts AS c
        ON m.RPSR_COD = c.RPSR_COD
    ORDER BY 
        CASE 
            WHEN m.RPSR_COD = "FGN" THEN 1
            WHEN m.RPSR_COD = "SDY" THEN 2
            WHEN m.RPSR_COD = "LIT" THEN 3
            WHEN m.RPSR_COD = "CSM" THEN 4
            WHEN m.RPSR_COD = "HP"  THEN 5
            WHEN m.RPSR_COD = "UF"  THEN 6
            WHEN m.RPSR_COD = "CR"  THEN 7
            WHEN m.RPSR_COD = "DT"  THEN 8
            WHEN m.RPSR_COD = "OTH" THEN 9
            ELSE 10
	END
	;
QUIT;

/* Step 4: Format counts into N (Pct%) columns */
DATA rpsr_final;
    SET rpsr_complete;

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
