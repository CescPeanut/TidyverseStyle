library(lubridate)
library(nycflights13)
library(dplyr)
library(ggplot2)

# Creat date
ymd("2017-01-31")
ymd(20170131)
# Creat date-time
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

# example of creating date-time in tibble
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

flights <- flights
# example2
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt

# Visualise the distribution of departure across the year
flights_dt %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day


# or within a single day
flights_dt %>% 
  filter(dep_time < ymd(20130102)) %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 600) # 600 s = 10 minutes


# getting components of datetime
datetime <- ymd_hms("2016-07-08 12:34:56")
year(datetime)
month(datetime)
mday(datetime)


# the relationship between departure minute and average delay duration
flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, avg_delay)) +
  geom_line()

# So why do we see that pattern with the actual departure times?
# Well, like much data collected by humans, there¡¯s a strong bias
# towards flights leaving at ¡°nice¡± departure times. Always be
# alert for this sort of pattern whenever you work with data
# that involves human judgement!

ggplot(sched_dep, aes(minute, n)) +
  geom_line()

# Rounding: floor_date(), round_date(), ceiling_date()
flights_dt %>% 
  count(week = floor_date(dep_time, "week")) %>% 
  ggplot(aes(week, n)) +
  geom_line()

# Setting components: use update()
flights_dt %>% 
  mutate(dep_hour = update(dep_time, yday = 1)) %>% 
  ggplot(aes(dep_hour)) +
  geom_freqpoly(binwidth = 300)


# Durations
h_age <- today() - ymd(19791014)
h_age
as.duration(h_age)

# Periods: different from durations
days(50) + hours(25) + minutes(2)
10 * (months(6) + days(1))

