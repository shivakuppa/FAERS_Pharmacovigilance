/**************************************************************************************************
* PROGRAM : imp_23Q4
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

%macro import_faers(file);
    %let fname = %upcase(&file);
    %let lname = %lowcase(&file);

    PROC PRINTTO LOG = "C:\dev\faers\log\imp_&lname.23Q4.log" NEW;
    RUN;

    PROC IMPORT OUT= WORK.&file.23Q4 
                DATAFILE= "C:\dev\faers\data\raw\2023\&fname.23Q4.TXT" 
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
