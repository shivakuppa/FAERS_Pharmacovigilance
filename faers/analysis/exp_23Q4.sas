/**************************************************************************************************
* PROGRAM : exp_23Q4
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

%macro export_all_formats(lib=ARAW23, outpath=C:\dev\faers\data\raw\2023);

    %let datasets = demo23q4 drug23q4 indi23q4 outc23q4 reac23q4 rpsr23q4 ther23q4;
    %let formats = csv xpt xml xls;

    %do i = 1 %to %sysfunc(countw(&datasets));
        %let dsn = %scan(&datasets, &i);

        /* Export to CSV */
        PROC EXPORT DATA= &lib..%upcase(&dsn)  
            OUTFILE= "&outpath.\&dsn..csv"  
            DBMS=CSV REPLACE;
            GETNAMES=YES;
        RUN;

        /* Export to XPT */
        LIBNAME xptout XPORT "&outpath.\&dsn..xpt";
        DATA xptout.%upcase(&dsn);
            SET &lib..%upcase(&dsn);
        RUN;
        LIBNAME xptout CLEAR;

        /* Export to XML */
        LIBNAME xmlout XMLV2 "&outpath.\&dsn..xml";
        DATA xmlout.%upcase(&dsn);
            SET &lib..%upcase(&dsn);
        RUN;
        LIBNAME xmlout CLEAR;

        /* Export to XLS */
        PROC EXPORT DATA= &lib..%upcase(&dsn)  
            OUTFILE= "&outpath.\&dsn..xls"  
            DBMS=EXCEL REPLACE;
            GETNAMES=YES;
        RUN;

    %end;

%mend;

%export_all_formats(lib=ARAW23, outpath=C:\dev\faers\data\raw\2023);
