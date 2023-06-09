# Introduction
This project will combine SQL and Python in connecting, cleaning and analyzing the data to get an idea of how much money the hotel has made (compare revenue by year), consider discounts for customers from different market segments and understand hotel booking trends. The results of the insights are presented as visual data using Power BI for easier understanding and persuasion.

<div align="center"><img src=https://user-images.githubusercontent.com/122539964/231317969-cd822ba4-da81-4193-9b61-8dae6fc13335.jpg></div>

# Objective
In this project, I explored the business in the hospitality industry. The objective of this analysis is to examine the trend of hotel revenue growth per year and explore the possible relationship between guests and their personal cars to identify any patterns or trends that can be useful in optimizing hotel revenue. The expected outcomes include insights into factors driving hotel revenue growth, identifying areas for improvement, and developing targeted promotions or incentives to optimize revenue growth and improve profitability.

# Data
The data for this reporting is contains contains booking information for a city hotel and a resort hotel starting from January 2018 to August 2020 was taken from kaggle link: 
[Hotel Revenue](https://www.kaggle.com/datasets/govindkrishnadas/hotel-revenue).

Data to support the analysis - [ISO 3166-1 alpha-3 country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3).

Note: There is no data from September 2020 which may be because of the COVID 19 pandemic regulations imposed on the country in which the hotels are. 

# Use Case
The project on the analysis and visualization of hotel booking statistics and for building the dashboard using Power BI to present to conditional stakeholders. That can generate enormous insights that could help the hotel management company to outline different strategies and business planning.

Key questions:
1) What is the hotel revenue growth per year?
3) Is there any relation between guest and their personal cars? 
4) Is there any kind of trends/patterns observed in the data?

# Work Environment:
* Tool: [Jupyter notebook](https://jupyter.org/)
* Programming languages: [SQL](https://www.w3schools.com/sql/sql_intro.asp) and Python ([pandas](https://pypi.org/project/pandas/), [NumPy](https://numpy.org/))
* Visualization: [Power BI](https://powerbi.microsoft.com/en-ca/), [Matplotlib](https://matplotlib.org/) and [seaborn](https://seaborn.pydata.org)

# Project Pipeline
<img width="433" alt="Pipeline" src="https://user-images.githubusercontent.com/122539964/231315002-b1f994c5-33d7-4524-992b-d074663e53a0.png">

# The Power BI Dashboard

Click [Power BI](https://clipchamp.com/watch/mhFtWoGVPt6) to watch the visualization video.

![Hotel Revenue Power BI](https://user-images.githubusercontent.com/122539964/232811624-38b3a2ad-d983-4a86-9094-e15e700cfb38.png)

# Summary

Based on the aggregated information from the data set, we can answer 3 questions posed:
* Revenue can clearly be seen growing from 2018 to 2020. However, there are a few things to keep in mind here as 2018 revenue was for the second half of the year and 2020 revenue was from January to August of the year because Covid-19 has closed the world.
* The maximum parking size required could not be determined at this time due to insufficient data to answer this question. However, when looking at the details, the total number of hotel parking spaces did not fluctuate much year by year.
* One of the biggest trends we can see is that the Revenue (ADR) in the Resort Hotel in July and August every year was more than in the City Hotel. While, revenue of City Hotel beat revenue of Resort Hotel in the remaining 10 months of the year.

# References
Prabhash, B. (2021, January 14). _Tips to optimize ADR and occupancy rates at your independent hotel._ Hotelogix. https://www.hotelogix.com/blog/optimize-adr-and-occupancy-rates-for-your-hotel/

ISO 3166-1 alpha-3.(2023, February 01). In _Wikipedia_. https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3  

Krishnadas, G.(2022). _Hotel Revenue._[Data set]. Kaggle. https://www.kaggle.com/datasets/govindkrishnadas/hotel-revenue
