**************************;
*******Author: Luis Ortiz III;
*******Homework 1;
*******Date: 10/30/23;
 
*******Task 1******;

*******Make libname statement;

libname ncsu "/home/u63548610/Fall 2023";

*******Access the file using URL:;
Filename ncsuwolf URL "https://www4.stat.ncsu.edu/~online/datasets/Dry_Bean_Dataset.xlsx";

*******;

***This PROC step is used to import the datafile into SAS.;

PROC IMPORT datafile = ncsuwolf
replace
dbms = xlsx
out = work.import;
getnames = yes;
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

***This PROC step is used to create a scatterplot between MinorAxisLength and MajorAxisLength variables with color being added.;

PROC SGPLOT DATA = work.import;
SCATTER X = MinorAxisLength Y = MajorAxisLength/COLORRESPONSE = avg;
RUN;

***This PROC step is used to create the plot from the last step to every level of the class variable;

PROC SGPANEL DATA = work.import;
PANELBY class;
SCATTER X = MinorAxisLength Y = MajorAxisLength/COLORRESPONSE = avg;
RUN;






















*********************************
*******Task 2*************;

******I am a senior and a marketing major in the Poole College of Management.; 
******As a marketing major, I will use the data from consumers to predict their needs.;
******I will also be using data to understand consumer demographics such as where their purchases are being made.; 
******As a marketing major, it is crucial to understand that using data is a strategic investment, if the data is inaccurate, profits will be lost.;
******For this datafile as a marketer, I will be using this data for strategic purposes of where purchases are being made across the state of New York.; 
******Specifically, I will use this data to help my clients make the decision of where to invest.;
******I will also use this data to understand the largest place to market products.****

FILENAME FOOD '/home/u63548610/Fall 2023/Retail_Food_Stores.csv';

PROC IMPORT REPLACE DATAFILE = "/home/u63548610/Fall 2023/Retail_Food_Stores.csv"
DBMS = CSV
OUT = work.import;
GETNAMES = YES;
RUN;

PROC CONTENTS DATA = work.import;
RUN;

data work.import; 
set work.import;

***This is used to rename variables to suffice with SAS standards.;
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


***This barplot describes which county has the most stores for the product;

PROC SGPLOT DATA = work.import;
VBAR county;
run;

****Which county has the stores for the product to be marketed? The answer is Kings.;
****Observing this code, I was surprised that Kings county had a significantly larger amount of stores to sell a product.;

***This code discusses which establishment type in the state of New York has the most square footage.;


PROC SGPANEL DATA = work.import;
PANELBY state;
SCATTER X = establishment_type y = square_footage/group = county;
RUN;

****Which establishment type has the most square footage in the state of NY so it can be marketed? The answer is the JAC one with 500,000 square feet compared to JABC having 350,000 square feet.; 



****Looking at the graph, I was shocked to see one establishment type have a significantly larger size of square footage.;

****Observing this code, I will summarize it by stating the square footage in this graph has a max size of 500,000 with a mean of 4,954.This is crucial to understand so we will know which is the best place to market products.;
****I will also say that this code indicated that Kings county had the most stores to sell products.;
****This code also indicates which establishment type has the most square footage in the state of NY.;





****Observing the variables, county, operation type, establishment type, street name, city, and state is categorical.;
****License number, zip code, street number, and georeference are quantitative variables.;





*******https://catalog.data.gov/dataset/retail-food-stores;

*******This dataset is of interest to me because of the fact that as 
*******a marketer, I will use this data from New York to understand where consumers make purchases across the state in terms of retail food stores;


