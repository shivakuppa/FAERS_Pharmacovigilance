   /**********************************************************************
   *   PRODUCT:   SAS
   *   VERSION:   9.4
   *   CREATOR:   External File Interface
   *   DATE:      14SEP15
   *   DESC:      Generated SAS Datastep Code
   *   TEMPLATE SOURCE:  (None Specified.)
   ***********************************************************************/
      data WORK.REAC06Q1    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\dev\faers\data\raw\2006\REAC06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767
  firstobs=2 ;
         informat ISR best32. ;
         informat PT $55. ;
         informat VAR3 $1. ;
         format ISR best12. ;
         format PT $55. ;
         format VAR3 $1. ;
      input
                  ISR
                  PT $
                  VAR3 $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;
