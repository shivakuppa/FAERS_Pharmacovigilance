/**************************************************************************************************
* PROGRAM : imp_indi06Q1
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

PROC PRINTTO LOG = "C:\dev\faers\log\indi06Q1.log" NEW;
RUN;

PROC IMPORT OUT= WORK.Indi06Q1 
            DATAFILE= "C:\dev\faers\data\raw\2006\INDI06Q1.TXT" 
            DBMS=DLM REPLACE;
     DELIMITER='24'x; 
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=1000; 
RUN;

PROC PRINTTO;
RUN;
