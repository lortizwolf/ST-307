*****Author: Luis Ortiz III****;
*****Date: 12/11/23*****;

*********Task 2*********;

***Jenner bundle note: the original PROC IMPORT reads a local copy of the
   public NY State "Retail Food Stores" dataset
   (https://catalog.data.gov/dataset/retail-food-stores). This bundle
   substitutes a small inline sample with the establishment_type/
   square_footage columns the CLASS-based GLM ANOVA and the log-transformed
   re-analysis below actually use, so both PROC GLM steps run unmodified
   against it.;

DATA work.import;
  length establishment_type $5;
  input establishment_type $ square_footage;
  datalines;
JAC 2500
JAC 3100
JABC 1800
JAC 4200
JAC 500000
JABC 2100
JABC 1950
JAC 2800
JABC 3300
JABC 350000
JAC 2600
JABC 1750
JAC 1400
JABC 1600
JAC 2200
JABC 1900
JAC 2050
JABC 2400
JAC 1550
JAC 2700
;
RUN;

****Using the previous code to fit into a linear regression model*****;

PROC GLM DATA = work.import PLOTS(MAXPOINTS=500000)= all;
CLASS establishment_type;
model square_footage = establishment_type/CLPARM;
RUN;
QUIT;

Data work.import;
Set work.import;
log_square_footage_plus5 = log(square_footage + 5);
run;

****This GLM procedure also is from previous line saboved modified to re-analyze the data*****;

PROC GLM DATA = work.import PLOTS(MAXPOINTS=500000) = all;
CLASS establishment_type;
model log_square_footage_plus5 = establishment_type/CLPARM;
RUN;
QUIT;
