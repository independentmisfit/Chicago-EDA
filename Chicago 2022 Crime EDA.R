install.packages("tidyverse")
install.packages("plotly")
install.packages("scales")
install.packages("lubridate")
install.packages("MAP")
install.packages("mapdata")
install.packages("ggmap")
library(tidyverse)
library(scales)
library(lubridate)
library(plotly)
library(MAP)
library(mapdata)
library(ggmap)


# Import Data

crime <- read.csv("C:/Users/HP/Downloads/2022.csv")
crime_df <- crime %>% drop_na()
sum(duplicated(crime_df))

# Preview Data
str(crime_df)
glimpse(crime_df)
colnames(crime_df)

# Most Common crimes

common_crimes <- crime_df %>% group_by(`Primary.Type`) %>% count() %>% arrange(desc(n)) %>% rename(times_reported = n)
View(common_crimes)


# common crime bar plot

common_crimes_bar <-  ggplot(data = crime_df) + 
  geom_bar(mapping = aes(x = Primary.Type, fill = Arrest), width = .80) +
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Crimes in Chicago and Number of Times Reported in 2022",
       x = "Crime",
       y = " Number of reports made")

ggplotly(common_crimes_bar)

# Arrest Crimes
crimes_arrest <- crime_df %>% group_by(Arrest) %>% count() %>% rename(num_of_arrest = n) 


crimes_arrest_percentage <- crime_df %>% group_by(Arrest) %>% count() %>% rename(num_of_arrest = n) %>% 
  mutate(percentage = scales::percent(num_of_arrest/sum(crimes_arrest$num_of_arrest)))


ggplot(data = crimes_arrest_percentage) +
  geom_col(mapping = aes(x ="", y = num_of_arrest, fill = Arrest), color = "black")  +
  geom_text(aes(x ="", y = num_of_arrest, label = percentage, vjust = .5)) +
  coord_polar(theta = "y") + 
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  theme_void()

# Wards with Most Reported Crimes

crimes_ward <- crime_df %>% group_by(Ward) %>% count() %>% arrange(desc(n)) %>% 
  rename(times_reported = n)
View(crimes_ward)


# Wards bar plot

crimes_ward_plot <- ggplot(data = crime_df) +
  geom_bar(mapping = aes(x = as.character(Ward), fill = Arrest)) +
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Total Crimes Reported in Chicago Ward 2022",
       x = "Ward",
       y = " Number of reports made")
ggplotly(crimes_ward_plot)


# Districts with Most Reported Crimes

crimes_district <- crime_df %>% group_by(District) %>% count() %>% arrange(desc(n)) %>% 
  rename(times_reported = n)
View(crimes_district)


# District bar plot

crimes_district_plot <- ggplot(data = crime_df) +
  geom_bar(mapping = aes(x = as.character(District), fill = Arrest)) +
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  labs(title = "Total Crimes Reported in Chicago Ward 2022",
       x = "District",
       y = " Number of reports made")
ggplotly(crimes_district_plot)

# Community Areas with Most Reported Crimes

crimes_comm_areas <- crime_df %>% group_by(Community.Area) %>% count() %>% arrange(desc(n)) %>% 
  rename(times_reported = n)
View(crimes_comm_areas)

# Community Areas Plot

crime_comm_bar <- ggplot(data = crime_df) +
  geom_bar(mapping = aes(x = as.character(Community.Area), fill = Arrest), width = 0.5) + 
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Crimes in Various Community Areas in 2022",
       x = "Community Areas",
       y = " Number of reports made")
ggplotly(crime_comm_bar)


#crimes on different days of the week
crime_newdf <- crime_df %>% select(Date, Primary.Type, Arrest) %>%
  mutate(new_date = as.Date(Date, format = "%m/%d/%Y"), week_day = weekdays(new_date), mon = month.abb[month(new_date)]) 
crime_newdf

crime_weekday <- crime_newdf %>% group_by(week_day) %>% count() %>% arrange(desc(n))%>% 
  rename(times_reported = n)
crime_weekday


#crimes on different days of the week bar plot


crime_newdf$week_day <- factor(crime_newdf$week_day, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                                                                "Friday", "Saturday"))

crime_weekdays_bar <- crime_newdf  %>% 
  ggplot() +
  geom_bar(mapping = aes(x = week_day, fill = Arrest)) +
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  labs(title = "No. of Crimes Reported in Chicago on Diff. Days of the Week in 2022",
       x = "Week Days",
       y = " Number of reports made")

ggplotly(crime_weekdays_bar)



## Crimes reported in each month 

crime_month <- crime_newdf %>% group_by(mon) %>% count() %>% arrange(desc(n))%>% 
  rename(times_reported = n)
crime_month


## Crimes reported in each month bar plot

crime_newdf$mon <- factor(crime_newdf$mon, levels = c("Jan", "Feb", "Mar", "Apr","May", "Jun", "Jul", "Aug", 
                                                      "Sep", "Oct", "Nov", "Dec"))

crime_month_bar <- ggplot(data = crime_newdf) +
  geom_bar(mapping = aes(x = mon, fill = Arrest)) +
  scale_fill_manual(values = c("false" = "#FF0000", "true" = "#2B76CC")) +
  labs(title = "No. of Crimes Reported in Chicago on Months in 2022",
       x = "Months",
       y = " Number of reports made")

ggplotly(crime_month_bar)


## Crimes reported in each month line plot

ggplot(data = crime_month, aes(x = mon, y = times_reported, group = 1)) +
  geom_line(color = "#2B76CC", size = 1.5) +
  geom_point() +
  labs(title = "No. of Crimes Reported in Chicago on Months in 2022",
       x = "Months",
       y = " Number of reports made")


## Map of areas with reported crimes

crime_location <- crime_df %>% select(Longitude, Latitude)


chicago <- get_stamenmap(bbox = c(left = -88.0225, bottom = 41.5949, 
                                  right = -87.2713, top = 42.0677), zoom = 10)
chicago_map <- ggmap(chicago)

chicago_map + geom_point(data = crime_location, aes(x = Longitude, y = Latitude), color = "red")


## coordinates views of ares with most arrests
area_mostarrest <- crime_df %>% group_by(Longitude, Latitude) %>% count() %>% arrange(desc(n))
area_mostarrest


ggplotly(chicago_map + geom_point(data = filter(area_mostarrest, n == 284), aes(x = Longitude, y = Latitude)))
