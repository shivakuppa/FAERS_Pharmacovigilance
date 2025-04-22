   /**********************************************************************
   *   PRODUCT:   SAS
   *   VERSION:   9.4
   *   CREATOR:   External File Interface
   *   DATE:      14SEP15
   *   DESC:      Generated SAS Datastep Code
   *   TEMPLATE SOURCE:  (None Specified.)
   ***********************************************************************/
      data WORK.THER06Q1    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\dev\faers\data\raw\2006\THER06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767
  firstobs=2 ;
         informat ISR best32. ;
         informat DRUG_SEQ best32. ;
         informat START_DT best32. ;
         informat END_DT best32. ;
         informat DUR best32. ;
         informat DUR_COD $3. ;
         informat VAR7 $1. ;
         format ISR best12. ;
         format DRUG_SEQ best12. ;
         format START_DT best12. ;
         format END_DT best12. ;
         format DUR best12. ;
         format DUR_COD $3. ;
         format VAR7 $1. ;
      input
                  ISR
                  DRUG_SEQ
                  START_DT
                  END_DT
                  DUR
                  DUR_COD $
                  VAR7 $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;
