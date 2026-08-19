**************************;
*******Author: Luis Ortiz III;
*******Homework 1;
*******Date: 10/30/23;

***Jenner bundle note: the original PROC IMPORT reads the Dry Bean Dataset
   from a live NCSU URL (Dry_Bean_Dataset.xlsx). This bundle substitutes a
   small inline sample with the columns the scatterplot step needs
   (MinorAxisLength, MajorAxisLength, avg) so the SGPLOT/SGPANEL steps below
   run unmodified against it.;

DATA work.import;
  length Class $10;
  input MinorAxisLength MajorAxisLength Shapefactor1 Shapefactor2 Shapefactor3 Shapefactor4 Class $;
  datalines;
173.89 208.18 0.0073 0.0032 0.8348 0.9985 SEKER
182.73 200.52 0.0072 0.0035 0.9098 0.9987 SEKER
175.93 212.83 0.0072 0.0032 0.8494 0.9989 SEKER
182.52 210.56 0.0070 0.0033 0.8977 0.9906 SEKER
189.63 288.02 0.0068 0.0021 0.6803 0.9827 BOMBAY
187.53 292.05 0.0069 0.0021 0.6521 0.9781 BOMBAY
193.41 279.02 0.0066 0.0023 0.7054 0.9843 BOMBAY
189.11 274.51 0.0068 0.0022 0.6935 0.9779 BOMBAY
285.06 320.86 0.0045 0.0028 0.9118 0.9950 CALI
288.71 325.90 0.0045 0.0028 0.9109 0.9906 CALI
284.92 318.11 0.0045 0.0028 0.9146 0.9915 CALI
254.15 282.28 0.0050 0.0033 0.7984 0.9877 SIRA
257.13 279.99 0.0050 0.0034 0.8065 0.9888 SIRA
253.35 280.61 0.0050 0.0033 0.7940 0.9899 SIRA
188.23 227.31 0.0068 0.0031 0.8332 0.9954 DERMASON
190.10 229.02 0.0067 0.0031 0.8365 0.9878 DERMASON
189.05 228.10 0.0068 0.0031 0.8298 0.9885 DERMASON
185.02 222.14 0.0069 0.0032 0.8368 0.9874 DERMASON
189.99 227.90 0.0067 0.0031 0.8351 0.9881 DERMASON
188.78 226.99 0.0068 0.0031 0.8351 0.9880 DERMASON
;
RUN;

***This line of code below creates a new variable that is the average of the newly renamed shape factor variables.;

DATA work.import;
SET work.import;
avg = MEAN (Shapefactor1, Shapefactor2, Shapefactor3, Shapefactor4);
RUN;

***This PROC step is used to create a scatterplot between MinorAxisLength and MajorAxisLength variables with color being added.;

PROC SGPLOT DATA = work.import;
SCATTER X = MinorAxisLength Y = MajorAxisLength/COLORRESPONSE = avg;
RUN;

***This PROC step is used to create the plot from the last step to every level of the class variable;

PROC SGPANEL DATA = work.import;
PANELBY class;
SCATTER X = MinorAxisLength Y = MajorAxisLength/COLORRESPONSE = avg;
RUN;
