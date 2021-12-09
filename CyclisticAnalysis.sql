-- Find total ride counts for members vs casual riders
select
	member_casual as rider_type,
	count(*) as num_trips
from
	Rides
group by
	member_casual


-- Find average ride length by rider type
select
	member_casual as rider_type,
	avg(convert(bigint, ride_length)) as avg_ride_length
from
	Rides
group by
	member_casual


-- Find number of rides by rider type and day of week
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


-- Find number of rides by ride length and rider type
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


-- Find number of rides by station and rider type
select
	start_station_name,
	member_casual,
	count(*) as num_rides
from
	Rides
group by
	start_station_name, member_casual
order by
	num_rides desc


-- Find number of rides by station with latitude and longitude grouped by rider type
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


-- Find number of rides by month and year by station
select
	start_station_name as station_name,
	avg(start_lat) as latitude,
	avg(start_lng) as longitude,
	year,
	month,
	count(*) as num_rides
from
	Rides
group by
	start_station_name, year, month
order by
	start_station_name, year, month


-- Find number of rides by month and year by rider type
select
	year,
	month,
	member_casual,
	count(*) as num_rides
from
	Rides
group by
	year, month, member_casual
order by
	year, month, member_casual


-- Find number of rides by time of day and rider type
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


-- Find number of rides by ride length, rider type, and bike type
select ride_category, rider_type, bike_type, count(*) as num_rides
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
		rideable_type as bike_type,
		member_casual as rider_type
	from
		Rides
) a
group by
	ride_category, rider_type, bike_type
order by
	ride_category, rider_type, bike_type