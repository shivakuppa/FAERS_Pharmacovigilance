   /**********************************************************************
   *   PRODUCT:   SAS
   *   VERSION:   9.4
   *   CREATOR:   External File Interface
   *   DATE:      14SEP15
   *   DESC:      Generated SAS Datastep Code
   *   TEMPLATE SOURCE:  (None Specified.)
   ***********************************************************************/

/* *************************************************************************
* PROGRAM : datastep_outc06Q1
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
      data ARAW06.OUTC06Q1    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\dev\faers\data\raw\2006\OUTC06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767
  	  firstobs=2 ;
         informat ISR best32. ;
         informat OUTC_COD $2. ;
         informat VAR3 $1. ;
         format ISR best12. ;
         format OUTC_COD $2. ;
         format VAR3 $1. ;
      input
                  ISR
                  OUTC_COD $
                  VAR3 $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;
