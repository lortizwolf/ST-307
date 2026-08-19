**************************;
*******Author: Luis Ortiz III;
*******Homework 1;
*******Date: 10/30/23;

*******Task 1******;

***Jenner bundle note: the original PROC IMPORT reads the Dry Bean Dataset
   from a live NCSU URL (Dry_Bean_Dataset.xlsx). This bundle substitutes a
   small inline sample with the same columns the script renames, drops,
   labels, filters, and averages, so the FREQ/MEANS logic below runs
   unmodified against it.;

DATA work.import;
  length Class $10;
  input Area Perimeter MajorAxisLength MinorAxisLength AspectRatio
        ConvexArea Solidity Shapefactor1 Shapefactor2 Shapefactor3 Shapefactor4
        Extent Class $;
  datalines;
28395 610.29 208.18 173.89 1.197 28715 0.9888 0.0073 0.0032 0.8348 0.9985 0.7638 SEKER
28734 638.02 200.52 182.73 1.098 29172 0.9850 0.0072 0.0035 0.9098 0.9987 0.6836 SEKER
29380 624.11 212.83 175.93 1.210 30089 0.9764 0.0072 0.0032 0.8494 0.9989 0.7757 SEKER
30008 645.88 210.56 182.52 1.153 30587 0.9814 0.0070 0.0033 0.8977 0.9906 0.7326 SEKER
42101 785.02 288.02 189.63 1.519 42800 0.9837 0.0068 0.0021 0.6803 0.9827 0.8687 BOMBAY
42139 794.85 292.05 187.53 1.557 43005 0.9799 0.0069 0.0021 0.6521 0.9781 0.8901 BOMBAY
41981 774.29 279.02 193.41 1.443 42650 0.9843 0.0066 0.0023 0.7054 0.9843 0.8420 BOMBAY
40201 763.15 274.51 189.11 1.451 40977 0.9811 0.0068 0.0022 0.6935 0.9779 0.8474 BOMBAY
71401 858.99 320.86 285.06 1.125 72000 0.9917 0.0045 0.0028 0.9118 0.9950 0.6103 CALI
72890 875.10 325.90 288.71 1.129 73580 0.9906 0.0045 0.0028 0.9109 0.9906 0.6180 CALI
70988 862.47 318.11 284.92 1.116 71610 0.9913 0.0045 0.0028 0.9146 0.9915 0.6045 CALI
55989 741.35 282.28 254.15 1.111 56590 0.9894 0.0050 0.0033 0.7984 0.9877 0.6900 SIRA
56312 749.78 279.99 257.13 1.089 56950 0.9888 0.0050 0.0034 0.8065 0.9888 0.6738 SIRA
55710 738.02 280.61 253.35 1.108 56290 0.9897 0.0050 0.0033 0.7940 0.9899 0.6928 SIRA
33473 655.10 227.31 188.23 1.207 33898 0.9875 0.0068 0.0031 0.8332 0.9954 0.7442 DERMASON
34125 662.55 229.02 190.10 1.205 34580 0.9868 0.0067 0.0031 0.8365 0.9878 0.7396 DERMASON
33780 658.72 228.10 189.05 1.207 34190 0.9880 0.0068 0.0031 0.8298 0.9885 0.7462 DERMASON
32120 640.10 222.14 185.02 1.201 32530 0.9874 0.0069 0.0032 0.8368 0.9874 0.7469 DERMASON
33900 660.02 227.90 189.99 1.200 34310 0.9880 0.0067 0.0031 0.8351 0.9881 0.7480 DERMASON
33555 656.22 226.99 188.78 1.203 33950 0.9884 0.0068 0.0031 0.8351 0.9880 0.7474 DERMASON
;
RUN;

***This is the start of the datastep that will copy the bean dataset from permanent to temporary library.;

DATA work.import;
SET work.import;

***Used a rename statement that would rename the shapefactor variables.;
RENAME Shapefactor1 = SF1
       Shapefactor2 = SF2
       Shapefactor3 = SF3
       Shapefactor4 = SF4;

***Used to drop two variables.;

DROP AspectRatio;
DROP Extent;

***Used to add descriptive labels to the variables.;

LABEL ConvexArea = 'Convex Region'
      Solidity = 'Density'
      Area = 'Region';

***This WHERE statement is used to remove all observations except for DERMASON, SEKER, SIRA, BOMBAY, and CALI.;

WHERE CLASS IN ("DERMASON", "SEKER", "SIRA", "BOMBAY", "CALI");

***This line of code below creates a new variable that is the average of the newly renamed shape factor variables.;

avg = MEAN (Shapefactor1, Shapefactor2, Shapefactor3, Shapefactor4);

RUN;

***This PROC step is used to create a one-way contingency table with the average shape factor being less than 0.42 with no cumulative percentages.;

PROC FREQ DATA = work.import;
TABLES Class/nopercent nocum;
WHERE (avg < 0.42);

RUN;

***The PROC step above has the first value of Bombay being 442.;

***This PROC step is used ot make the Mean, Median, and SD for the area and perimeter variables.;

PROC MEANS DATA = work.import MEAN MEDIAN STD;
CLASS class;
var Area Perimeter;
RUN;
