**************************;
*****Author: Luis Ortiz III;
*****Homework 1;
*****Date: 9/18/23;

***Jenner bundle note: the original PROC IMPORT reads a local CSV
   (/home/u63548610/Fall 2023/credit_risk.csv). This bundle substitutes a
   small inline sample with the same columns the script actually uses
   (Income, Emp_length, Cred_length, Home, Intent) so the rest of the
   script -- rename, drop, sort, print -- runs unmodified against it.;

DATA work.creditrisk2;
  length Home $10 Intent $12;
  input Income Emp_length Cred_length Home $ Intent $;
  datalines;
38000 5 3 RENT PERSONAL
62000 9 6 MORTGAGE EDUCATION
27500 2 2 RENT MEDICAL
81000 12 9 OWN VENTURE
45500 4 4 RENT DEBTCONSOLIDATION
53000 7 5 MORTGAGE HOMEIMPROVEMENT
31000 3 1 RENT PERSONAL
97500 15 11 OWN EDUCATION
41200 6 4 RENT MEDICAL
68000 10 7 MORTGAGE VENTURE
29800 1 1 RENT PERSONAL
73400 11 8 OWN DEBTCONSOLIDATION
50200 6 5 MORTGAGE HOMEIMPROVEMENT
36700 4 3 RENT EDUCATION
88900 13 10 OWN VENTURE
44300 5 4 RENT MEDICAL
59600 8 6 MORTGAGE PERSONAL
33100 3 2 RENT DEBTCONSOLIDATION
76200 12 9 OWN HOMEIMPROVEMENT
48800 6 5 MORTGAGE EDUCATION
;
RUN;

*******Code to rename Emp_length and Cred_length;

DATA work.creditrisk2;
SET work.creditrisk2;

RENAME Emp_length = Length_of_Employment
      Cred_length = Length_of_Credit_History;

  ******Code to remove Home and Intent variables;

      DROP Home;
      DROP Intent;
      RUN;



******Code that sorts out the dataset by the Income Variable;

PROC SORT DATA = work.creditrisk2 OUT = sortedCreditRisk2;
BY Income;
RUN;



*******Code that prints out the first twenty rows of the sorted dataset;

PROC PRINT DATA = sortedCreditRisk2 (OBS=20);
RUN;
