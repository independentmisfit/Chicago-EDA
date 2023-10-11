## README

---
# Introduction
This report is aimed at analyzing crime data collated from the city of Chicago
in 2022. This analysis is geared at providing insights into crime ((with the exception of murders where data exists for each victim) in the city, uncovering trends, and discovering crime hot spots in Chicago. The data that forms the basis of this analysis is the **Crimes in Chicago (Year Wise)** obtained from [Kaggle](https://www.kaggle.com/datasets/onlyrohit/crimes-in-chicago?datasetId=2737440)



## Import the data
Drop all null values, and check for duplicates. Duplicate is 0 so data is free from null values, and duplicates


The data contains 219032 rows and 22 columns

Having seen the content of the data, we begin our explanatory data analysis
We wish to uncover:
* Most common Crime in the city
* How Often do Reported Crime lead to arrest.
* Which Ward, District, Community Area have the most prevalent crimes
* Total crimes reported on different days of the week
* Total crimes reported on different months of the year

We hope to answer all of the above in this report

## Most common Crime in the city
To deduce the most common crimes in Chicago, our focus shifts to the *Primary.Type* column. 


The analysis shows that **Theft** is the most common reported crime in Chicago, with 50,075 reported cases in 2022.
A graphical visualization of crimes in Chicago and number of times reported, helps us understand prevalent cases of theft is in Chicago.

The graph show the prevalence of **theft** in Chicago,and how it ranks far higher than other reported crimes.However, the graph shows the ratio of the arrest made in reported cases of every crime in the city. A quick observation of the graph shows that majority of crimes reported, do not lead to arrest. This brings us to the second focus of the report.

## How Often do Reported Crime lead to arrest

To deduce fully how often reported cases of crime in Chicago led to arrest in 2022, our focus is shifted to the **Arrest** column of our data.Arrest is categorized in boolean **true** for positive arrests, and **false** foe negatiive cases of arrest.

The pie chart reveals that 11% of reported cases of crime led to arrest, which corresponds to 24,600 arrests in 2022 in Chicago City.

## Wards with Most Reported Crimes

The wards with the most number of crimes reported is given below

**Ward 42** has the most reported cases of crime, with a total of 11,612	 crimes reported from the Ward.
**Ward 19** has the least reported cases of crime, with 1,894 crimes reported in 2022



## Districts


District 6 has the most crime reported, with 13,620 reported cases in 2022.District 31 had a total of 8 crimes reported in 2022. A graphical visualization of crimes reported in different district in Chicago in 2022 is detailed below

## Community Areas


Community Area 25 had the most crimes reported in 2022, with 11,455 crimes reported, as opposed to community Area 9 which had 277 reported criminal cases.


## Total Crimes reported on each days of the Week in Chicago in 2022
Focus shifts to determining the total crimes reported on various days of the week in Chicago in 2022. 
The **crime_weekday** data frame shows the total crimes reported in each day of the week arranged in descending order.
Notice that in the **as.Date** function, which converts the **Date** column to a character datatype, the format is given. This step is important as the date was saved in the month-day-year format. The **%Y** in the format informs R that the date is prefix with a 20 or 19 e.g 1988 or 2022. 

# Key Takeaways

- 219,032 crimes were reported in 50 wards, 23 Districts, and 77 Community Areas.
- Theft is the most reported case of crime.
- Only 11% of crimes reported lead to arrest
- Ward 42 has the most reported cases of crime and ward 19 the least.
- District 6 had the most crimes reported, and district 31 had the least.
- Community Area 25 had the most prevalent cases of reported crime, while community area 9 have the least.
- Most crimes are reported on weekends, namely Friday and Saturday.
- Most crimes are reported in summer months (June, July, August, September) and early fall (October)
An interactive dashboard detailing the summary of these report can be accessed here (https://public.tableau.com/app/profile/oluseyi.folorunso/viz/CHICAGO2022CRIMEDASHBOARD/CHICAGO2022CRIMEDASHBOARD)
