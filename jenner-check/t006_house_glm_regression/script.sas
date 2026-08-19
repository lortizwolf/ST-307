*****Author: Luis Ortiz III****;
*****Date: 12/11/23*****;

*****Task 1*****;

***Jenner bundle note: the original PROC IMPORT reads the Ames-style house
   dataset from a live NCSU URL (lortiz_house.csv). This bundle substitutes
   a small inline sample with the columns the DELETE/compute/DROP block and
   the SGPLOT + GLM regression below actually use (MoSold, SalePrice,
   YearRemodAdd, GrLivArea, ExterQual, BsmtUnfSF, RoofMatl), so the rest of
   the script runs unmodified against it.;

DATA work.import;
  length ExterQual $2 RoofMatl $8;
  input MoSold SalePrice YearRemodAdd GrLivArea ExterQual $ BsmtUnfSF RoofMatl $;
  datalines;
5 208500 2003 1710 Gd 150 CompShg
6 181500 1976 1262 TA 284 CompShg
6 223500 2002 1786 Gd 434 CompShg
2 140000 1970 1717 TA 540 CompShg
12 250000 2000 2198 Gd 490 CompShg
9 143000 1995 1362 TA 64 CompShg
8 307000 2005 1694 Gd 317 CompShg
11 200000 1973 2090 TA 216 CompShg
4 129900 1950 1774 TA 952 CompShg
1 118000 1965 1077 TA 140 CompShg
7 345000 2006 1913 Ex 490 CompShg
9 144000 2006 1652 TA 0 CompShg
6 279500 1993 2217 Gd 953 CompShg
11 157000 2004 1077 TA 694 CompShg
4 132000 1972 1040 TA 290 CompShg
10 149000 1999 1182 TA 0 CompShg
1 90000 1950 912 TA 851 CompShg
5 159000 1978 1494 Gd 380 CompShg
5 139000 1965 1253 TA 280 CompShg
6 325300 2005 1981 Ex 705 CompShg
;
RUN;

***This is the start of the datastep that will copy the bean dataset from permanent to temporary library.;

DATA work.import;
SET work.import;

****This removes observations where the MoSold variable takes on a value less than or equal to 4.***;

IF (MoSold <= 4) THEN DELETE;

*****This is used to create a new variable with a name of my choosing and divided by 10000***;

PriceInMillions = SalePrice/10000;

*****This is used to drop the variables.*****;

DROP BsmtUnfSF;
DROP RoofMatl;
RUN;

****This step is using a PROC step to create a scatter plot on the x and y axis and colors them****;

PROC SGPLOT DATA = work.import;
SCATTER X = YearRemodAdd Y = SalePrice/GROUP = ExterQual;
RUN;

****This step is used to fit a multiple linear regression model using SalePrice as the response varibale with YearRemodAdd and GrLivArea as predictors****;
PROC GLM DATA = work.import plots = all;
model SalePrice = YearRemodAdd GrLivArea/CLPARM;
RUN;
quit;
