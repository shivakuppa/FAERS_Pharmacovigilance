/**************************************************************************************************
* PROGRAM : datastep_drug06Q1
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

/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      16SEP15
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
data WORK.Drug06Q1;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile 'C:\dev\faers\data\raw\2006\DRUG06Q1.TXT' delimiter = '$' MISSOVER DSD lrecl=32767 firstobs=2;
   informat ISR best32.;
   informat DRUG_SEQ best32.;
   informat ROLE_COD $2.;
   informat DRUGNAME $70.;
   informat VAL_VBM best32.;
   informat ROUTE $24.;
   informat DOSE_VBM $94.;
   informat DECHAL $1.;
   informat RECHAL $1.;
   informat LOT_NUM $12.;
   informat EXP_DT best32.;
   informat NDA_NUM best32.;
   informat VAR13 $1.;
   format ISR best12.;
   format DRUG_SEQ best12.;
   format ROLE_COD $2.;
   format DRUGNAME $70.;
   format VAL_VBM best12.;
   format ROUTE $24.;
   format DOSE_VBM $94.;
   format DECHAL $1.;
   format RECHAL $1.;
   format LOT_NUM $12.;
   format EXP_DT best12.;
   format NDA_NUM best12.;
   format VAR13 $1.;
   input
       ISR
       DRUG_SEQ
       ROLE_COD $
       DRUGNAME $
       VAL_VBM
       ROUTE $
       DOSE_VBM $
       DECHAL $
       RECHAL $
       LOT_NUM $
       EXP_DT
       NDA_NUM
       VAR13 $
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;
