# Cyclistic Bike Sharing Case Study

## Introduction
This case study was completed as part of my Google Data Analytics Professional Certificate. The case study uses a fictional company Cyclistic, but is based on real data from the Chicago-based, Lyft owned, bike sharing company [Divvy](https://www.divvybikes.com). In this case, we are asked to determine what the primary differentiating factors are between casual riders (ones who purchase a single ride or a day pass) and member riders (ones who purchase an annual membership). Cyclistic has determined that member riders are more profitable and would like to run a marketing campaign to attempt to convert casual riders into members.
## Data
### Obtaining & Understanding
Data for this project was obtained with permission from Motivate International Inc. under their [Data License Agreement](https://www.divvybikes.com/data-license-agreement). I downloaded the most recent 12 months of ride data available (11/2020-10/2021) to use for my analysis. This data can be found [here](https://www.divvybikes.com/system-data).

<img width="1199" alt="Sample ride data" src="https://user-images.githubusercontent.com/10602696/145052152-b5ee4086-4684-4ef9-b406-cf9fa4ce48b8.png"></img>
*A small sample of the original Divvy data*



There are several fields for each ride:
- **ride_id** - Unique ID for the ride
- **rideable_type** - Type of bike used for the ride(classic, docked, or electric)
- **started_at** and **ended_at** - Dates and times the ride started and ended
- **start_station_name** and **end_station_name** - Names of the stations the ride started at and ended at
- **start_station_id** and **end_station_id** - Unique IDs of the stations the ride started at and ended at
- **start_lat**, **start_lng**, **end_lat**, and **end_lng** - Coordinates of the stations the ride started at and ended at

### Cleaning & Transforming
For the cleaning process, I began by compiling the individual CSV data files into one large file. I believe the total number of rows was about 5.3 million. Next, I used a simple R script to create some cleaner date columns (**date**, **month**, **day**, and **year**) as well as a column which calculated the length of the ride (**ride_length**).

After that, I imported the CSV file into a table called **Rides** in a new SQL Server database **Cyclistic**. I then performed some data cleaning in SQL such as selecting and deleting rides missing station names, as well as rides using stations specifically for testing or maintenance. I also removed any rides shorter than 60 seconds or longer than 24 hours. After this, I was ready to begin my analysis.
## Analysis
When beginning my analysis, I realized that for such a large dataset, it wouldn't really be possible to look at each individual data point. Instead, for each experiment I used SQL queries to summarize the data and group it in meaningful ways. Then I took the resulting, smaller tables and used Tableau to visualize them and look for any inisghts that stood out. I looked at many possible factors to determine what differences exist between casual and member riders; all of them are written as SQL queries [here]().

A few of the experiments I did:
- What days of the week are most popular for member vs casual riders?
- What length of rides are most popular for member vs casual riders?
- Which stations are member riders using the most? What about casual riders?
- What times do member riders tend to rider? What about casual riders?
## Recommendations
1. T
2. t
3. t
## Conclusion
