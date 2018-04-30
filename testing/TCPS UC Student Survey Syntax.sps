* Encoding: UTF-8.

To select undergraduate students only 

USE ALL.
COMPUTE filter_$=(Q3 = 1).
VARIABLE LABELS filter_$ 'Q3 = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

To unselect "undergraduate students only" 

FILTER OFF.
USE ALL.
EXECUTE.

To select graduate students only 

USE ALL.
COMPUTE filter_$=(Q3 = 4).
VARIABLE LABELS filter_$ 'Q3 = 4 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

To unselect "graduate students only" 

FILTER OFF.
USE ALL.
EXECUTE.

Commands for frequencies and descriptives for items


Commands for frequencies and descriptives for demographic items 

FREQUENCIES VARIABLES=Q1 Q2 Q3 Q4 Q4.0 Q4a Q5 Q6 Q7
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=Q2
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.

Commands for frequencies for and descriptives Lever 1 Agreement items 

FREQUENCIES VARIABLES=Q8_Q12_1_1 Q8_Q12_1_2 Q8_Q12_1_3 Q8_Q12_1_4 Q8_Q12_1_5 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 1 Importance items 

FREQUENCIES VARIABLES=Q8_Q12_2_1 Q8_Q12_2_2 Q8_Q12_2_3 Q8_Q12_2_4 Q8_Q12_2_5 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 2 Agreement items 

FREQUENCIES VARIABLES=Q13_Q17_1_1 Q13_Q17_1_2 Q13_Q17_1_3 Q13_Q17_1_4 Q13_Q17_1_5
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 2 Importance items 

FREQUENCIES VARIABLES=Q13_Q17_2_1 Q13_Q17_2_2 Q13_Q17_2_3 Q13_Q17_2_4 Q13_Q17_2_5
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 3 Agreement items 

FREQUENCIES VARIABLES=Q18_Q23_1_1 Q18_Q23_1_3 Q18_Q23_1_2 Q18_Q23_1_7 Q18_Q23_1_4 Q18_Q23_1_6 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 3 Importance items 

FREQUENCIES VARIABLES=Q18_Q23_2_1 Q18_Q23_2_3 Q18_Q23_2_2 Q18_Q23_2_7 Q18_Q23_2_4 Q18_Q23_2_6 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 4 Agreement items 

FREQUENCIES VARIABLES= Q24_Q28_1_1 Q24_Q28_1_2 Q24_Q28_1_7 Q24_Q28_1_5 Q24_Q28_1_6
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 4 Importance items 

FREQUENCIES VARIABLES=Q24_Q28_2_1 Q24_Q28_2_2 Q24_Q28_2_7 Q24_Q28_2_5 Q24_Q28_2_6 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 5 Agreement items 

FREQUENCIES VARIABLES=Q29_Q34_1_1 Q29_Q34_1_2 Q29_Q34_1_3 Q29_Q34_1_4 Q29_Q34_1_5 Q29_Q34_1_7 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 5 Importance items 

FREQUENCIES VARIABLES=Q29_Q34_2_1 Q29_Q34_2_2 Q29_Q34_2_3 Q29_Q34_2_4 Q29_Q34_2_5 Q29_Q34_2_7
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 6 Agreement items 

FREQUENCIES VARIABLES=35_Q38_1_1 Q35_Q38_1_2 Q35_Q38_1_3 Q35_Q38_1_4
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for Lever 6 Importance items 

FREQUENCIES VARIABLES= Q35_Q38_2_1 Q35_Q38_2_2 Q35_Q38_2_3 Q35_Q38_2_4 
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

Commands for frequencies and descriptives for items from the Emotional Engagement subscale of the Student Engagement Questionnaire (SEQ-EE; i.e., the validation items) 

FREQUENCIES VARIABLES=Q40_Q44_1 Q40_Q44_3 Q40_Q44_4 Q40_Q44_5
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.



Commands for reliability for lever and validaton items


Commands for reliability for Lever 1 Agreement items 

RELIABILITY 
/VARIABLES= Q8_Q12_1_1 Q8_Q12_1_2 Q8_Q12_1_3 Q8_Q12_1_4 Q8_Q12_1_5 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 1 Importance items 

RELIABILITY 
/VARIABLES= Q8_Q12_2_1 Q8_Q12_2_2 Q8_Q12_2_3 Q8_Q12_2_4 Q8_Q12_2_5 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 2 Agreement items 

RELIABILITY 
/VARIABLES=Q13_Q17_1_1 Q13_Q17_1_2 Q13_Q17_1_3 Q13_Q17_1_4 Q13_Q17_1_5
  /SCALE('ALL VARIABLES') ALL  
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 2 Importance items 

RELIABILITY 
/VARIABLES=Q13_Q17_2_1 Q13_Q17_2_2 Q13_Q17_2_3 Q13_Q17_2_4 Q13_Q17_2_5 
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 3 Agreement items 

RELIABILITY 
/VARIABLES=Q18_Q23_1_1 Q18_Q23_1_3 Q18_Q23_1_2 Q18_Q23_1_7 Q18_Q23_1_4 Q18_Q23_1_6 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 3 Importance items 

RELIABILITY 
/VARIABLES=Q18_Q23_2_1 Q18_Q23_2_3 Q18_Q23_2_2 Q18_Q23_2_7 Q18_Q23_2_4 Q18_Q23_2_6 
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 4 Agreement items 

RELIABILITY 
/VARIABLES=Q24_Q28_1_1 Q24_Q28_1_2 Q24_Q28_1_7 Q24_Q28_1_5 Q24_Q28_1_6 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 4 Importance items 

RELIABILITY 
/VARIABLES=Q24_Q28_2_1 Q24_Q28_2_2 Q24_Q28_2_7 Q24_Q28_2_5 Q24_Q28_2_6 
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 5 Agreement items 

RELIABILITY 
/VARIABLES=Q29_Q34_1_1 Q29_Q34_1_2 Q29_Q34_1_3 Q29_Q34_1_4 Q29_Q34_1_5 Q29_Q34_1_7 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 5 Importance items 

RELIABILITY 
/VARIABLES=Q29_Q34_2_1 Q29_Q34_2_2 Q29_Q34_2_3 Q29_Q34_2_4 Q29_Q34_2_5 Q29_Q34_2_7 
  /SCALE('ALL VARIABLES') ALL 
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 6 Agreement items 


RELIABILITY 
/VARIABLES=Q35_Q38_1_1 Q35_Q38_1_2 Q35_Q38_1_3 Q35_Q38_1_4
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for Lever 6 Importance items 

RELIABILITY 
/VARIABLES=Q35_Q38_2_1 Q35_Q38_2_2 Q35_Q38_2_3 Q35_Q38_2_4 
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.

Commands for reliability for items from the SEQ-EE (i.e., the validation items) 

RELIABILITY 
/VARIABLES= Q40_Q44_1 Q40_Q44_3 Q40_Q44_4 Q40_Q44_5
  /SCALE('ALL VARIABLES') ALL
/MODEL=ALPHA   
/STATISTICS=DESCRIPTIVE SCALE CORR   
/SUMMARY=TOTAL MEANS.


Commands for computing agreement levers

Compute Lever1A = (Q8_Q12_1_1 + Q8_Q12_1_2 + Q8_Q12_1_3 + Q8_Q12_1_4 + Q8_Q12_1_5)/5.
Execute.
Compute Lever2A = (Q13_Q17_1_1 + Q13_Q17_1_2 + Q13_Q17_1_3 + Q13_Q17_1_4 + Q13_Q17_1_5)/5.
Execute.
Compute Lever3A = (Q18_Q23_1_1 + Q18_Q23_1_3 + Q18_Q23_1_2 + Q18_Q23_1_7 + Q18_Q23_1_4 + Q18_Q23_1_6)/6.
Execute.
Compute Lever4A = (Q24_Q28_1_1 + Q24_Q28_1_2 + Q24_Q28_1_7 + Q24_Q28_1_5 + Q24_Q28_1_6)/5.
Execute.
Compute Lever5A = (Q29_Q34_1_1 + Q29_Q34_1_2 + Q29_Q34_1_3 + Q29_Q34_1_4 + Q29_Q34_1_5 + Q29_Q34_1_7)/6.
Execute.
Compute Lever6A = (Q35_Q38_1_1 + Q35_Q38_1_2 + Q35_Q38_1_3 + Q35_Q38_1_4)/4.
Execute.

Commands for computing importance levers


Compute Lever1i = (Q8_Q12_2_1 + + Q8_Q12_2_2 + + Q8_Q12_2_3 + + Q8_Q12_2_4 + + Q8_Q12_2_5)/5.
Execute.
Compute Lever2i = (Q13_Q17_2_1 + Q13_Q17_2_2 + Q13_Q17_2_3 + Q13_Q17_2_4 + Q13_Q17_2_5)/5.
Execute.
Compute Lever3i = (Q18_Q23_2_1 + Q18_Q23_2_3 + Q18_Q23_2_2 + Q18_Q23_2_7 + Q18_Q23_2_4 + Q18_Q23_2_6)/6.
Execute.
Compute Lever4i = (Q24_Q28_2_1 + Q24_Q28_2_2 + Q24_Q28_2_7 + Q24_Q28_2_5 + Q24_Q28_2_6)/5.
Execute.
Compute Lever5i = (Q29_Q34_2_1 + Q29_Q34_2_2 + Q29_Q34_2_3 + Q29_Q34_2_4 + Q29_Q34_2_5 + Q29_Q34_2_7)/6.
Execute.
Compute Lever6i = (Q35_Q38_2_1 + Q35_Q38_2_2 + Q35_Q38_2_3 + Q35_Q38_2_4)/4.
Execute.

Commands for computing Emoptional Engagement subscale of the Student Engagement Quiestionaire (SEQ-EE)

Compute EmoEngage =  (Q40_Q44_1 + Q40_Q44_3 + Q40_Q44_4 + Q40_Q44_5)/4.
Execute.


Commands for descriptives for levers and SEQ-EE 


Commands for descriptives for agreement levers  

DESCRIPTIVES VARIABLES=Lever1A Lever2A Lever3A Lever4A Lever5A Lever6A 
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.

Commands for descriptives for importance levers 

DESCRIPTIVES VARIABLES=Lever1i Lever2i Lever3i Lever4i Lever5i Lever6i
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.

Commands for descriptives for SEQ-EE

DESCRIPTIVES VARIABLES= EmoEngage
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.


Commands for correlating levers and SEQ-EE 

CORRELATIONS
  /VARIABLES=Lever1A Lever2A Lever3A Lever4A Lever5A Lever6A Lever1i Lever2i Lever3i Lever4i 
    Lever5i Lever6i EmoEngage
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE.
