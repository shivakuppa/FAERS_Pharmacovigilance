/**********************************************************************
   *   PRODUCT:   SAS
   *   VERSION:   9.4
   *   CREATOR:   External File Interface
   *   DATE:      14SEP15
   *   DESC:      Generated SAS Datastep Code
   *   TEMPLATE SOURCE:  (None Specified.)
   ***********************************************************************/

/* *************************************************************************
* PROGRAM : datastep_indi06Q1
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
      data ARAW06.INDI06Q1    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\dev\faers\data\raw\2006\INDI06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767
  	  firstobs=2 ;
         informat ISR best32. ;
         informat DRUG_SEQ best32. ;
         informat INDI_PT $45. ;
         format ISR best12. ;
         format DRUG_SEQ best12. ;
         format INDI_PT $45. ;
      input
                  ISR
                  DRUG_SEQ
                  INDI_PT $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;
