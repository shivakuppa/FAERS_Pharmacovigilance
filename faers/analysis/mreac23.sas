PROC SQL;
    CREATE TABLE REAC AS
    SELECT a.D_AGEGRP,
           b.PT
    FROM Afinal23.demo23_d AS a
    INNER JOIN Afinal23.reac23_d AS b
        ON a.PRIMARYI = b.PRIMARYI
       AND a.CASEID   = b.CASEID
	WHERE a.D_AGEGRP NE "MISSIN"
    ;
QUIT;


PROC SQL;
    CREATE TABLE reac_counts AS
    SELECT 
        PT,
        SUM(CASE WHEN D_AGEGRP = 'GROUP1' THEN 1 ELSE 0 END) AS N1,
        SUM(CASE WHEN D_AGEGRP = 'GROUP2' THEN 1 ELSE 0 END) AS N2,
        SUM(CASE WHEN D_AGEGRP = 'GROUP3' THEN 1 ELSE 0 END) AS N3,
        SUM(CASE WHEN D_AGEGRP = 'GROUP4' THEN 1 ELSE 0 END) AS N4,
        /* Total is sum of the four counts */
        COUNT(PT) AS TOTAL
    FROM Reac
    GROUP BY PT
    ORDER BY TOTAL DESC;
QUIT;

DATA reac_final;
    SET reac_counts;

    /* Format each as N (Pct%) */
    GROUP1 = CATX(' ', N1, '(' || PUT( (N1/TOTAL)*100, 5.1) || '%)');
    GROUP2 = CATX(' ', N2, '(' || PUT( (N2/TOTAL)*100, 5.1) || '%)');
    GROUP3 = CATX(' ', N3, '(' || PUT( (N3/TOTAL)*100, 5.1) || '%)');
    GROUP4 = CATX(' ', N4, '(' || PUT( (N4/TOTAL)*100, 5.1) || '%)');

    DROP N1 N2 N3 N4;
RUN;

DATA AFINAL23.reac_table;
    SET work.reac_final;
RUN;
