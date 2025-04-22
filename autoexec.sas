/* *************************************************************************
* PROGRAM : autoexec.sas
* PROGRAMMER : Lajeeth Thangavel
* VALIDATOR : Shiva
* DATE : 4/2/25
* PURPOSE : 
* SOURCE : C:\dev\faers\data\raw\2006
* TARGET : C:\dev\faers\analysis


* MODIFYING HISTORY : 
****************************************************************************
DATE :                   NAME :                      REASON FOR MODIFICATION: 
****************************************************************************
*/ 

PROC PRINTTO LOG='C:\dev\autoexec.log' NEW;
RUN;

OPTIONS LINESIZE=120 PAGESIZE=54 ORIENTATION=LANDSCAPE OBS=MAX NOFMTERR VALIDVARNAME=V6
		MERROR SERROR MPRINT MLOGIC SYMBOLGEN;

*Defining library for aers 2006;
LIBNAME ARAW06 'C:\dev\faers\data\raw\2006';
LIBNAME AFINAL06 'C:\dev\faers\data\final\2006';
LIBNAME ABACK06 'C:\dev\faers\backup';
LIBNAME AXML06 'C:\dev\faers\xml';
LIBNAME AXPT06 'C:\dev\faers\xpt';
LIBNAME AQC06 'C:\dev\faers\qc';


LIBNAME ARAW23 'C:\dev\faers\data\raw\2023';
LIBNAME AFINAL23 'C:\dev\faers\data\final\2023';
/*LIBNAME ABACK23 'C:\dev\faers\backup';*/
/*LIBNAME AXML23 'C:\dev\faers\xml';*/
/*LIBNAME AXPT23 'C:\dev\faers\xpt';*/
/*LIBNAME AQC23 'C:\dev\faers\qc';*/

PROC PRINTTO;
RUN;
