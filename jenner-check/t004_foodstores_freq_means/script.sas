**************************;
*******Author: Luis Ortiz III;
*******Homework 1;
*******Date: 10/30/23;

***Jenner bundle note: the original PROC IMPORT reads a local copy of the
   public NY State "Retail Food Stores" dataset
   (https://catalog.data.gov/dataset/retail-food-stores), whose source CSV
   header row produces space-containing column names like 'Zip Code' and
   'Square Footage' -- which is exactly why the script renames them below
   using SAS name-literal (n-literal) syntax. This bundle substitutes a
   small inline sample that reproduces those same space-containing names
   directly on the DATA step (via RENAME=), so the 'name'n rename block
   below, and the FREQ/MEANS steps that follow, run unmodified.;

DATA work.import (RENAME=(zip='Zip Code'n lic='License Number'n op='Operation Type'n
                           strnum='Street Number'n strname='Street Name'n
                           sf='Square Footage'n etype='Establishment Type'n));
  length county $10 op $6 etype $5 strname $20;
  input county $ zip lic op $ strnum strname $ sf etype $;
  datalines;
Kings 11201 100234 STORE 210 ATLANTIC_AVE 2500 JAC
Kings 11215 100235 STORE 415 FLATBUSH_AVE 3100 JAC
Kings 11217 100236 STORE 88 FULTON_ST 1800 JABC
Kings 11238 100237 STORE 320 VANDERBILT 4200 JAC
Kings 11201 100238 STORE 12 CLINTON_ST 500000 JAC
Queens 11354 100239 STORE 45 MAIN_ST 2100 JABC
Queens 11375 100240 STORE 67 QUEENS_BLVD 1950 JABC
Queens 11101 100241 STORE 200 VERNON_BLVD 2800 JAC
NewYork 10001 100242 STORE 350 7TH_AVE 3300 JABC
NewYork 10023 100243 STORE 90 BROADWAY 350000 JABC
NewYork 10011 100244 STORE 15 8TH_AVE 2600 JAC
Bronx 10451 100245 STORE 500 GRAND_CONCOURSE 1750 JABC
Bronx 10456 100246 STORE 22 WEBSTER_AVE 1400 JAC
Richmond 10301 100247 STORE 60 BAY_ST 1600 JABC
Kings 11205 100248 STORE 145 MYRTLE_AVE 2200 JAC
Kings 11220 100249 STORE 300 5TH_AVE 1900 JABC
Queens 11434 100250 STORE 77 SUTPHIN_BLVD 2050 JAC
NewYork 10025 100251 STORE 210 AMSTERDAM_AVE 2400 JABC
Bronx 10462 100252 STORE 88 WESTCHESTER_AVE 1550 JAC
Kings 11249 100253 STORE 400 BEDFORD_AVE 2700 JAC
;
RUN;

***This is used to rename variables to suffice with SAS standards.;
data work.import;
set work.import;

rename
'Zip Code'n = zip_code
'Street Number'n = street_number
'License Number'n = license_number
'Operation Type'n = operation_type
'Street Name'n = street_name
'Square Footage'n = square_footage
'Establishment Type'n = establishment_type;
run;

****This code is used to display which counties have the most stores to carry the product and the percentage of each.;
****Looking at this code, I was surprised I had to rename variables of this length.;

PROC FREQ DATA = work.import;
TABLES county;
RUN;

***This PROC step explains how many stores have a certain amount of frequency across the state of NY without cumulative percentages.;

PROC FREQ DATA = work.import;
TABLES square_footage/nopercent nocum;
RUN;

****This PROC step is used ot calculate the number, mean, median, std, min, and max of the square footage.;

PROC MEANS DATA = work.import N MEAN STD MIN MAX;
VAR square_footage;
RUN;
