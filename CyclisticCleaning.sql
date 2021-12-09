-- Find and delete all rides missing station names
select
	*
from
	Rides
where
	start_station_name = '' or
	end_station_name = ''

delete
from
	Rides
where
	start_station_name = '' or
	end_station_name = ''


-- Find all distinct station names with a count of how many times they were used
select
	start_station_name,
	count(*) as times_used
from
	Rides
group by
	start_station_name
order by
	times_used

select
	end_station_name,
	count(*) as times_used
from
	Rides
group by
	end_station_name
order by
	times_used

-- Find and delete all rides using station names containing 'test'
select
	distinct start_station_name
from
	Rides
where
	start_station_name like '%test%'

delete
from
	Rides
where
	start_station_name like '%test%'


-- Find and delete all rides using station names containing 'base'
select
	distinct start_station_name
from
	Rides
where
	start_station_name like '%base%'

delete
from
	Rides
where
	start_station_name like '%base%'

select
	distinct end_station_name
from
	Rides
where
	end_station_name like '%base%'

delete
from
	Rides
where
	end_station_name like '%base%'


-- Find and delete all rides longer than 86400 seconds (24 hours)
select
	*
from
	Rides
where
	ride_length > 86400
order by
	ride_length desc

delete
from
	Rides
where
	ride_length > 86400


-- Find and delete all rides shorter than 60 seconds
select
	*
from
	Rides
where
	ride_length < 60

delete
from
	Rides
where
	ride_length < 60