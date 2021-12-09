# Cyclistic Bike Sharing Case Study

## Case Introduction
This case study was completed as part of my Google Data Analytics Professional Certificate. The case study uses a fictional company Cyclistic, but is based on real data from the Chicago-based, Lyft owned, bike sharing company [Divvy](https://www.divvybikes.com). In this case, we are asked to determine what the primary differentiating factors are between casual riders (ones who purchase a single ride or a day pass) and member riders (ones who purchase an annual membership). Cyclistic has determined that member riders are more profitable and would like to run a marketing campaign to attempt to convert casual riders into members.
## Data Preparation
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
For the cleaning process, I began by compiling the individual CSV data files into one large file. I believe the total number of rows was about 5.3 million. Next, I used a simple [R script]() to create some cleaner date columns (**date**, **month**, **day**, and **year**) as well as a column which calculated the length of the ride (**ride_length**).

After that, I imported the CSV file into a table called **Rides** in a new SQL Server database **Cyclistic**. I then performed some [data cleaning]() in SQL such as selecting and deleting rides missing station names, as well as rides using stations specifically for testing or maintenance. I also removed any rides shorter than 60 seconds or longer than 24 hours. After this, I was ready to begin my analysis.
## Data Analysis
When beginning my analysis, I realized that for such a large dataset, it wouldn't really be possible to look at each individual data point. Instead, for each experiment I used [SQL queries]() to summarize the data and group it in meaningful ways. Then I took the resulting, smaller tables and used Tableau to [visualize]() them and look for any inisghts that stood out. I looked at many possible factors to determine what differences exist between casual and member riders.

A few of the experiments I did:
- What days of the week are most popular for member vs casual riders?
```
select
  DATENAME(WEEKDAY, Rides.date) as week_day,
  member_casual,
  count(*) as num_rides
from
  Rides
group by
  DATENAME(weekday, Rides.date), member_casual
order by
  week_day, member_casual
```
- What length of rides are most popular for member vs casual riders?
```
select
  ride_category,
  member_casual,
  count(*) as num_rides
from 
(
  select
    case
      when ride_length between 0 and 300 then '0-5 min'
      when ride_length between 300 and 600 then '05-10 min'
      when ride_length between 600 and 900 then '10-15 min'
      when ride_length between 900 and 1200 then '15-20 min'
      when ride_length between 1200 and 1500 then '20-25 min'
      when ride_length between 1500 and 1800 then '25-30 min'
      when ride_length between 1800 and 3600 then '30-60 min'
      else '60+ min'
    end as ride_category,
    member_casual
  from
    Rides
) a
group by
  ride_category, member_casual
order by
  ride_category
```
- Which stations are member riders using the most? What about casual riders?
```
select
  start_station_name,
  avg(start_lat) as latitude,
  avg(start_lng) as longitude,
  member_casual,
  count(*) as num_rides
from
  Rides
group by
  start_station_name, member_casual
order by
  start_station_name, member_casual
```
- What times do member riders tend to rider? What about casual riders?
```
select
  member_casual as rider_type,
  convert(time, started_at, 22) as time_started,
  count(*) as num_rides
from
  Rides
group by
  member_casual, convert(time,started_at,22)
order by
  num_rides desc
```

After reviewing all my analysis, I discovered some interesting insights that led me to two recommendations for Cyclistic to better market annual memberships to casual riders.

## Business Recommendations
1. **Highlight the benefits of regularly using Cyclistic bikes for short commutes and errands within the city**
    - Based on ride length analysis, members tend to use Cyclistic bikes much more often than casual riders overall, but for shorter trips. 49% of member rides are 10 minutes or less, compared to only 25% of casual rides. On the other hand, less than 8% of member rides are 30 minutes or longer, compared to 26% of casual rides.
<img width="800" alt="Ride length analysis" src="https://user-images.githubusercontent.com/10602696/145412940-6073b44d-fb91-4ff1-8dfa-ff1f3f17b70f.png"></img>
    - Looking at a map of station usage percentage by members vs casual riders, there's a clear trend that stations along the coast of Lake Michigan are more likely to used by casual riders than members. This points to a hypothesis that casual riders are more likely to use Cyclistic bikes for leisure and tourism purposes only, compared to member riders who use the bikes to get around the city for other purposes.
<img width="800" alt="Ride location analysis" src="https://user-images.githubusercontent.com/10602696/145414128-544b468f-48a1-4844-bee9-76ea1ea15b22.png"></img>
2. **Advertise morning rides, either for exercise or commutes**
    - Looking at the average number of rides per day by time, we see 22.93% of total member rides occur in the morning (5AM-11AM) versus only 12.58% of total casual rides. Midday (11AM-5PM) contained 42.18% of casual rides versus 37.73% of member rides. Evening (5PM-11PM) saw 37.14% of casual rides versus 35.46% of member rides. The largest gap was in the morning, showing that proportionally more members ride in the morning than casual riders.
<img alt="Ride time analysis" src="https://user-images.githubusercontent.com/10602696/145414969-851051e5-7868-4677-8256-70be2160315a.png"></img>
    - Looking at average and median ride length by time, we notice that ride lengths for casual riders fall significantly from a median of around 18-21 minutes from 10AM-5PM to a median of around 10-13 minutes from 5AM-8AM. This shows that it's probable some casual riders are already using Cyclistic bike for morning exercise or commutes. Targeted marketing may be successful in increasing the number of active casual users during this time period.
<img width="800" alt="Median ride length analysis" src="https://user-images.githubusercontent.com/10602696/145416232-8290a38b-dcb0-405c-bdf5-32a1bb9c5c0b.png"></img>
## Case Conclusion
I'll conclude by simply summarizing my process for this case study:
1. First, I thoroughly read the case and understood the relevant business problem being presented.
3. Next, I downloaded and explored the data, and I chose the appropriate tools to use based on the data and the business problem.
4. Then I cleaned and transformed the data to prepare for analysis.
5. After that, I began my analysis by constructing various hypotheses.
6. I selected the relevant data to test each hypothesis and notated any insights afterwards.
7. Once I completed my hypothesis testing, I determined which results best answered the business problem.
8. Finally, I used my findings as recommendations for my stakeholders within the company.
