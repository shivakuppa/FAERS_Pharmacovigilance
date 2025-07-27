/******************************************************************
*PROGRAM   : AERS06q1_Report.sas
*PROGRAMMER: Lajeeth
*VALIDATOR : Prem
*DATE      : 7/15/2025
*PURPOSE   : AERS2006 Q1 Final Report in pdf document including
             Graphs, Summary tables and Patient listings
*SOURCE    : C:\dev\faers\tlg
*TARGET    : C:\dev\faers\adhoc

*MODIFYING HISTORY:
--------------------------------------------------------------------
DATE:		NAME:				REASON FOR MODIFICATION:
--------------------------------------------------------------------
*******************************************************************/
ods pdf file="C:\dev\faers\adhoc\toc_report.pdf" style=journal startpage=now pdftoc=1;
ods proctitle=on;
ods escapechar='^';  /* Enable inline style formatting */
/* === 1. Introduction (TOC Entry) === */
ods proclabel "1. Introduction";
proc report data=sashelp.class(obs=1) nowd;
   column name;
   define name/noprint;
   title "^S={font_size=18pt font_weight=bold just=Center font_face='Times New Roman'}  Introduction";
   footnote;
run;

ods pdf text="^S={font_size=14pt font_weight=bold just=left font_face='Times New Roman'} Adverse Event Reporting System (AERS) Report";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}The Adverse Event Reporting System (AERS) is a computerized database maintained by the U.S. Food and Drug Administration (FDA) to support post-marketing safety surveillance of pharmaceutical and therapeutic biological products. It plays a critical role in identifying new adverse events and medication errors that may not have been detected during clinical trials.";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}This report presents comprehensive Graphical summaries, summary tables and patient-level listings derived from the AERS database to support ongoing pharmacovigilance activities. The analyses include adverse event frequencies, drug-event relationships, outcomes, and demographic trends. Data used in this report were sourced from AERS 2006Q1 updates, which are released by the FDA approximately 4 to 6 weeks after the end of each calendar quarter.";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}The AERS database includes the following core datasets:";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- DEMO: Patient demographic and administrative information";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- DRUG: Reported drug data (suspect, concomitant, interacting)";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- REAC: Coded adverse event terms using MedDRA";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- OUTC: Patient outcomes such as death, hospitalization, or disability";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- RPSR: Sources of the report (healthcare professional, consumer, etc.)";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- THER: Therapy dates (start/end) for reported drugs";
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}		- INDI: Indications for drug administration";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=16pt} The primary objective of this report is to summarize and present key safety findings, stratified by drug, event, and patient characteristics, to assist in evaluating the post-marketing safety profile of the products under surveillance."*/;


/* =================== Parent Node: 2. Patient-Level Listings (TOC Entry) ======================= */
ods pdf startpage=now;
ods proclabel = "2. Patient-Level Listings";
/*ods pdf toc_level = 1;*/

title "Patient-Level Listings";
proc report data=sashelp.class nowd;
    column name;
	define name/noprint;
run;
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}The Patient-Level Listings section provides detailed, case-level adverse event data as reported to the AERS system. Each listing includes information on patient demographics, suspect and concomitant drugs, therapy dates, adverse event terms, outcomes, indications, and source of report.";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}These listings allow for case traceability and support in-depth clinical and regulatory review of individual adverse event reports.";

/*---- Child Node: Demographics ----*/
ods proclabel = "	 2.1 Demographics Listing";
/*ods pdf toc_level = 2;*/

title "Demographics Listing";
PROC REPORT DATA=afinal06.Demo06q1 (obs=1000) NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
           STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};
   COLUMN ( isr i_f_cod event_dt mfr_dt fda_dt rept_cod age age_cod d_age d_agegrp gndr_cod wt wt_cod d_wt 
               rept_dt occp_cod death_dt COUNTRY);
  
   DEFINE isr/id "Report's unique number"; 
                             
   DEFINE i_f_cod/"Code for initial*" "or followup*" "status" display flow;
   DEFINE event_dt/"Date adverse event*" "occurred or began" display flow;
   DEFINE mfr_dt/"Date manufacturer*" "first received*" "initial (or follow-up)*" "information" display flow;
   DEFINE fda_dt/"Date FDA*" "received report" display;
   DEFINE rept_cod/"Code for the type*" "of report submitted" display;
   DEFINE age/"Numeric value of patient's*" "age at event" display;
   DEFINE age_cod/"Unit abbreviation*" "for patient's" "age" display;
   DEFINE d_age/"Derived*" "age" display;
   DEFINE d_agegrp/page "Derived*" "age group" display;
   DEFINE gndr_cod/"Code for*" "patient's sex" display ;
   DEFINE wt/"Numeric value of*" "patient's weight" display flow;
   DEFINE wt_cod/"Unit abbreviation for*" " patient's weight" display;
   DEFINE d_wt/"Derived*" "weight" display ;
   DEFINE rept_dt/"Date report*" "was sent" display;
   DEFINE occp_cod/"Abbreviation for*" "initial reporter's*" "type of occupation" display;
   DEFINE death_dt/"Date patient*" "died" display;
   DEFINE COUNTRY/"Reports*" "Country" display ;

   Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   TITLE2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   TITLE3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Demographic Listings";
RUN;

/*---- Child Node: Demographics ----*/
ods proclabel = "		2.1 Demographics Listing";
/*ods pdf toc_level = 2;*/

title "Demographics Listing";*/;

/*---- Child Node: Drug ----*/
ods proclabel = "	 2.2 Drugs Listing";
/*ods pdf toc_level = 2;*/

title "Drugs Listing";
proc report data=afinal06.Drug06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing 
    style={outputwidth=100%}
    style(header)={just=c};  /* Match your Demographic Listings */

   column isr drug_seq role_cod drugname val_vbm route dose_vbm dechal rechal lot_num exp_dt nda_num der_drug;

   define isr        / "Report's unique number";
   define drug_seq   / "Number for identifying drug*from Report's unique number" display flow;
   define role_cod   / "Code for the*role drug played*in event" display flow;
   define drugname   / "Name of drug" display flow;
   define val_vbm    / "Code for source*of drug name" display flow;
   define route      / "Route of drug*administration" display flow;
   define dose_vbm   / "Exact text for dose,*frequency and route" display flow;
   define dechal     / "Dechallenge code*(reaction when drug*therapy stopped)" display flow;
   define rechal     / "Rechallenge code*(reaction when drug*therapy restarted)" display flow;
   define lot_num    / "Lot number of drug" display flow;
   define exp_dt     / "Expiration date*of drug" display flow;
   define nda_num    / "NDA number" display flow;
   define der_drug   / "Derived Drug Name" display flow;

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Drug Listings";
run;

/*---- Child Node: Drug ----*/
ods proclabel = "		2.2 Drugs Listing";
/*ods pdf toc_level = 2;*/

title "Drugs Listing";

/*---- Child Node: Reactions ----*/
ods proclabel = "	 2.3 Reactions Listing";
/*ods pdf toc_level = 2;*/

title "Reactions Listing";
proc report data=afinal06.Reac06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing
    style={outputwidth=100%}
    style(header)={just=c};

   column isr pt;

   define isr / "Report's unique number" display flow 
                     style(column)={just=c};
   define pt / "Preferred term to describe the event" display flow
   					 style(column)={just=c};

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Reaction Listings";
run;

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.3 Reactions Listing";
/*ods pdf toc_level = 2;*/

title "Reactions Listing";

/*---- Child Node: Reactions ----*/
ods proclabel = "	 2.4 Outcomes Listing";
/*ods pdf toc_level = 2;*/

title "Outcomes Listing";
proc report data=afinal06.Outc06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing
    style={outputwidth=100%}
    style(header)={just=c};

   column isr outc_cod;

   define isr / "Report's unique number" display flow 
                     style(column)={just=c};
   define outc_cod / "Code for patient outcomes" display flow
   					 style(column)={just=c};

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Outcome Listings";
run;

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.4 Outcomes Listing";
/*ods pdf toc_level = 2;*/

title "Outcomes Listing";

/*---- Child Node: Reactions ----*/
ods proclabel = "	 2.5 Report Sources Listing";
/*ods pdf toc_level = 2;*/

title "Report Sources Listing";
proc report data=afinal06.Rpsr06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing
    style={outputwidth=100%}
    style(header)={just=c};

   column isr rpsr_cod;

   define isr / "Report's unique number" display flow 
                     style(column)={just=c};
   define rpsr_cod / "Code for patient outcomes" display flow
   					 style(column)={just=c};

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Report Source Listings";
run;

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.5 Report Sources Listing";
/*ods pdf toc_level = 2;*/

title "Report Sources Listing";

/*---- Child Node: Reactions ----*/
ods proclabel = "	 2.6 Therapies Listing";
/*ods pdf toc_level = 2;*/

title "Therapies Listing";
proc report data=afinal06.Ther06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing
    style={outputwidth=100%}
    style(header)={just=c};

   column isr drug_seq start_dt end_dt drv_dur;

   define isr / "Report's unique number" display flow 
                     style(column)={just=c};
   define drug_seq / "Number for identifying drug from ISR" display flow
   					 style(column)={just=c};
   define start_dt / "Date when drug therapy started" display flow 
                     style(column)={just=c};
   define end_dt / "Date when drug therapy ended" display flow 
                     style(column)={just=c};
   define drv_dur / "Derived duration" display flow 
                     style(column)={just=c};

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Therapy Listings";
run;

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.6 Therapies Listing";
/*ods pdf toc_level = 2;*/

title "Therapies Listing";

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.7 Indications Listing";
/*ods pdf toc_level = 2;*/

title "Indications Listing";
proc report data=afinal06.Indi06q1 (obs=1000) nowd headline headskip spacing=1 split='*' missing
    style={outputwidth=100%}
    style(header)={just=c};

   column isr drug_seq indi_pt;

   define isr      / "Report's unique number" display flow 
                     style(column)={just=c};
   define drug_seq / "Number for identifying drug from ISR" display flow 
                     style(column)={just=c};
   define indi_pt  / "Preferred term to describe the event" display flow 
                     style(column)={just=c};

   title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';
   title2 j=right font='Times New Roman' height=10pt c=black "&sysdate9";
   title3 j=center font='Times New Roman' height=13pt c=black bold "ADVERSE EVENT REPORTING SYSTEM (AERS)";
   title4 j=center font='Times New Roman' height=12pt c=black bold "Indication Listings";
run;

/*---- Child Node: Indications ----*/
ods proclabel = "	 2.7 Indications Listing";
/*ods pdf toc_level = 2;*/

title "Indications Listing";

/*==================== Parent Node: 3. Summary Tables (TOC Entry) ====================================*/
ods pdf startpage=now;

ods proclabel = "3. Summary Tables";
/*ods pdf toc_level = 1;*/

title "Summary Tables";
proc report data=sashelp.class nowd;
    column name;
	define name/noprint;
run;

ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}The Summary Tables section presents aggregated safety data to support pharmacovigilance signal detection and risk evaluation. These tables include analyses of adverse events by System Organ Class (SOC) and Preferred Term (PT), drug-event frequencies, patient outcomes (e.g., death, hospitalization), and demographic trends (e.g., gender, age groups).";
ods pdf text=" ";  /* Blank line */
ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}The data are summarized to provide a high-level overview of potential safety concerns and reporting patterns across the database.";

/*---- Child Node: Demographics ----*/
ods proclabel = "	 3.1 Demographics Summary Table";
/*ods pdf toc_level = 2;*/

title "Demographics Summary By Age Group";
PROC REPORT DATA=ALIST06.DemoList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

   COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))"; 
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))";

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Demographic Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Drugs ----*/
ods proclabel = "	 3.2 Drugs Summary Table";
/*ods pdf toc_level = 2;*/

title "Drugs Summary By Age Group";
PROC REPORT DATA=ALIST06.DrugList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Drug Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Reactions ----*/
ods proclabel = "	 3.3 Reactions Summary Table";
/*ods pdf toc_level = 2;*/

title "Reactions Summary By Age Group";
PROC REPORT DATA=ALIST06.ReacList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Reaction Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Outcomes ----*/
ods proclabel = "	 3.4 Outcomes Summary Table";
/*ods pdf toc_level = 2;*/

title "Outcomes Summary By Age Group";
PROC REPORT DATA=ALIST06.OutcList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Outcome Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Report Sources ----*/
ods proclabel = "	 3.5 Report Sources Summary Table";
/*ods pdf toc_level = 2;*/

title "Report Sources Summary By Age Group";
PROC REPORT DATA=ALIST06.RpsrList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Report Source Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Therapies ----*/
ods proclabel = "	 3.6 Therapies Summary Table";
/*ods pdf toc_level = 2;*/

title "Therapies Summary By Age Group";
PROC REPORT DATA=ALIST06.TherList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Therapy Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*---- Child Node: Indications ----*/
ods proclabel = "	 3.7 Indications Summary Table";
/*ods pdf toc_level = 2;*/

title "Indications Summary By Age Group";
PROC REPORT DATA=ALIST06.IndiList NOWD HEADLINE HEADSKIP SPACING=1 SPLIT="*" MISSING 
                  STYLE = {OUTPUTWIDTH=100%}  STYLE (HEADER) = {JUST=C};

    COLUMN ORDER CAT STAT GROUP_1 GROUP_2 GROUP_3 GROUP_4 TOTAL;

	DEFINE ORDER/ORDER NOPRINT;
	DEFINE CAT/GROUP " ";
	DEFINE STAT/DISPLAY " ";
	DEFINE GROUP_1/DISPLAY "Group1 (0-25) *" "(N=%TRIM(&AGEGRP1))"; 
	DEFINE GROUP_2/DISPLAY "Group2 (26-50) *" "(N=%TRIM(&AGEGRP2))"; 
	DEFINE GROUP_3/DISPLAY "Group3 (51-75) *" "(N=%TRIM(&AGEGRP3))"; 
	DEFINE GROUP_4/DISPLAY "Group4 (75+) *" "(N=%TRIM(&AGEGRP4))";  
	DEFINE TOTAL/DISPLAY "Total *" "(N=%TRIM(&AGEGRP5))"; 

    Title1 font="Times New Roman" c=black bold height=10pt j=left "Project: AERS 2006Q1" j=r 'Page ^{thispage} of ^{lastpage}';

	TITLE2 j=right font='Times New Roman' height=10pt c=black bold "&sysdate9";
	TITLE3 j=center font='Times New Roman' height=13pt c=black bold "Indication Summary Table";
	TITLE4 j=center font='Times New Roman' height=12pt c=black bold "Derived Age Group";

RUN;

/*==================== Parent Node: 4. Graphs and Visual Summaries (TOC Entry) ====================================*/
ods pdf startpage=now;

ods proclabel = "4. Graphs and Visual Summaries";
/*ods pdf toc_level = 1;*/

title "4. Graphs and Visual Summaries";
proc report data=sashelp.class nowd;
    column name;
	define name/noprint;
run;

ods pdf text="^S={font_size=12pt just=left font_face='Times New Roman'}This section presents key graphical summaries derived from the FAERS (FDA Adverse Event Reporting System) database to enhance understanding of adverse event trends and patient characteristics. Visual displays help identify safety signals, monitor reporting patterns, and support data-driven decision-making.";

ods proclabel="		4.1 Trellis Panel- Average Age by Occupation, Split by Gender Group";
Title "Average Age by Occupation, Split by Gender Group";

ods listing gpath="C:\dev\faers\tlg\sas_graphs" image_dpi=200;
ods graphics / reset imagename="panel_plot" imagefmt=png width=600px height=400px imagemap;

proc sgpanel data=afinal06.ademog;
   panelby occp_cod;
/*   hbar gndr_cod / response=d_age stat=mean datalabel;*/

   styleattrs datacolors=(red green orange cyan) backcolor=vpav wallcolor=white;

   hbar gndr_cod / response=d_age stat=mean group=occp_cod datalabel;
   colaxis label="Occupation";
   rowaxis label="Average Age";
   title "Average Age by Occupation, Split by Gender";
run;
ods graphics / reset;
title;

ods proclabel="		4.2 VBox - Weight Level by Age Group";
Title "Weight Level by Age Group";
ods graphics / reset width=600px height=400px imagename='Cholesterol' imagefmt=gif;
ods html file='wtbyagerange.html' path='C:\dev\faers\tlg\sas_graphs' style=myblock;

proc sgplot data=afinal06.ademog noautolegend;
   title1 "Weight Level by Age Group";
   styleattrs datacolors=(red green purple orange cyan) backcolor=vpav wallcolor=pwh;
   vbox d_wt / category=d_grp boxwidth=0.7 group=d_grp;
   xaxis label= "Derived Weight";
   yaxis label="Age code";
   keylegend / title="Age Group";
/*    format age_cod $agecod.;*/
run;
ods html close;

ods pdf close;


