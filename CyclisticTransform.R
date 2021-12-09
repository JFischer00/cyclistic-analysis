trips <- read_csv("csv_final/combined.csv")

trips$date <- as.Date(mdy_hm(trips$started_at))
trips$month <- format(as.Date(trips$date), "%m")
trips$day <- format(as.Date(trips$date), "%d")
trips$year <- format(as.Date(trips$date), "%Y")
trips$day_of_week <- format(as.Date(trips$date), "%A")
trips$ride_length <- period_to_seconds(hms(trips$ride_length))

write.csv(trips, file = 'csv_final/combined_clean.csv')