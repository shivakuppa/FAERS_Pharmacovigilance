/**************************************************************************************************
* PROGRAM : exp_06Q1
* PROGRAMMER : Shiva Kuppa
* VALIDATOR: Lajeeth
* DATE : 4/7/2025
* PURPOSE : C:\dev\faers\data\raw\2006
* SOURCE: C:\dev\faers\analysis
* 
*
* MODIFYING HISTORY
***************************************************************************************************
DATE:                   NAME:                       REASON FOR MODIFICATION:
***************************************************************************************************
*/

%macro export_all_formats(lib=ARAW06, outpath=C:\dev\faers\data\raw\2006);

    %let datasets = demo06q1 drug06q1 indi06q1 outc06q1 reac06q1 rpsr06q1 ther06q1;
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

%export_all_formats(lib=ARAW06, outpath=C:\dev\faers\data\raw\2006);
