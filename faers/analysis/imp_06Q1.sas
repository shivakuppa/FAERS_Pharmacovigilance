/**************************************************************************************************
* PROGRAM : imp_06Q1
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

%macro import_faers(file);
    %let fname = %upcase(&file);
    %let lname = %lowcase(&file);

    PROC PRINTTO LOG = "C:\dev\faers\log\imp_&lname.06Q1.log" NEW;
    RUN;

    PROC IMPORT OUT= WORK.&file.06Q1 
                DATAFILE= "C:\dev\faers\data\raw\2006\&fname.06Q1.TXT" 
                DBMS=DLM REPLACE;
         DELIMITER='24'x; 
         GETNAMES=YES;
         DATAROW=2; 
         GUESSINGROWS=1000; 
    RUN;

    PROC PRINTTO;
    RUN;
%mend import_faers;

%import_faers(demo)
%import_faers(drug)
%import_faers(indi)
%import_faers(outc)
%import_faers(reac)
%import_faers(rpsr)
%import_faers(ther)
