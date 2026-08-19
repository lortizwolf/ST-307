**************************;
*******Author: Luis Ortiz III;
*******Homework 1;
*******Date: 10/30/23;

***Jenner bundle note: the original PROC IMPORT reads a local copy of the
   public NY State "Retail Food Stores" dataset
   (https://catalog.data.gov/dataset/retail-food-stores). This bundle
   substitutes a small inline sample with the county/establishment_type/
   square_footage columns the bar chart and panel plot below actually use,
   so the VBAR and SGPANEL steps run unmodified against it.;

DATA work.import;
  length county $10 establishment_type $5 state $2;
  input county $ establishment_type $ square_footage state $;
  datalines;
Kings JAC 2500 NY
Kings JAC 3100 NY
Kings JABC 1800 NY
Kings JAC 4200 NY
Kings JAC 500000 NY
Queens JABC 2100 NY
Queens JABC 1950 NY
Queens JAC 2800 NY
NewYork JABC 3300 NY
NewYork JABC 350000 NY
NewYork JAC 2600 NY
Bronx JABC 1750 NY
Bronx JAC 1400 NY
Richmond JABC 1600 NY
Kings JAC 2200 NY
Kings JABC 1900 NY
Queens JAC 2050 NY
NewYork JABC 2400 NY
Bronx JAC 1550 NY
Kings JAC 2700 NY
;
RUN;

***This barplot describes which county has the most stores for the product;

PROC SGPLOT DATA = work.import;
VBAR county;
run;

***This code discusses which establishment type in the state of New York has the most square footage.;

PROC SGPANEL DATA = work.import;
PANELBY state;
SCATTER X = establishment_type y = square_footage/group = county;
RUN;
