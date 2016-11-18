library(ggplot2)
library(plyr)
library(dplyr)

# set your working directory using setwd() function below
# remove the # before the line
# and put the location of folder containing your files, in quotes, in the parenthesis
# hit command-return to run any line of code
#setwd()

# read in year data into variables
crash15 <- read.csv("2014alcocrash.csv", header=TRUE, sep = ",")
crash14 <- read.csv("2014alcocrash.csv", header=TRUE, sep = ",")
crash13 <- read.csv("2013alcocrash.csv", header=TRUE, sep = ",")
crash12 <- read.csv("2012alcocrash.csv", header=TRUE, sep = ",")
crash11 <- read.csv("2011alcocrash.csv", header=TRUE, sep = ",")
crash10 <- read.csv("2010alcocrash.csv", header=TRUE, sep = ",")
crash09 <- read.csv("2009alcocrash.csv", header=TRUE, sep = ",")
crash08 <- read.csv("2008alcocrash.csv", header=TRUE, sep = ",")
crash07 <- read.csv("2007alcocrash.csv", header=TRUE, sep = ",")
crash06 <- read.csv("2006alcocrash.csv", header=TRUE, sep = ",")
crash05 <- read.csv("2005alcocrash.csv", header=TRUE, sep = ",")
crash04 <- read.csv("2004alcocrash.csv", header=TRUE, sep = ",")

# combine year data into one dataframe
crashes <- rbind(crash04, crash05, crash06, crash07, crash08, crash09, crash10, crash11, crash12, crash13, crash14, crash15)

### Features Engineering (create new variables)

# quarter off day hours
crashes <- transform(crashes,
                     day.part = as.factor(mapvalues(HOUR_OF_DAY, c(0:23, 99),
                                                    c(rep("night", 5), rep("morning", 5), rep("mid", 6), rep("evening", 4), rep("night", 4), "unknown"))))

crashes <- transform(crashes, day.part = factor(day.part, levels = c("morning", "mid", "evening", "night", "unknown")))

# create commute variables
crashes <- transform(crashes,
                     commute = as.factor(mapvalues(HOUR_OF_DAY, c(0:23, 99),
                                                   c(rep("offpeak", 5), rep("commute", 5), rep("offpeak", 6), rep("commute", 4), rep("offpeak", 4), "unknown"))))


# label months
crashes <- transform(crashes,
                     CRASH_MONTH = mapvalues(CRASH_MONTH, c(1:12),
                                             c("Jan", "Feb", "Mar", "Apr", "May", "June",
                                               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")))

# order months correctly
crashes <- transform(crashes, CRASH_MONTH = factor(CRASH_MONTH, levels = c("Jan", "Feb", "Mar", "Apr", "May",
                                                                           "June", "Jul", "Aug", "Sep", "Oct",
                                                                           "Nov", "Dec")))

# day of week labels
crashes <- transform(crashes, DAY_OF_WEEK = mapvalues(DAY_OF_WEEK, c(1:7),
                                                      c("Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat")))

# order days of the week correctly
crashes <- transform(crashes, DAY_OF_WEEK = factor(DAY_OF_WEEK, levels = c("Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat")))

# create season variables
crashes <- transform(crashes,
                     season = mapvalues(CRASH_MONTH, c("Jan", "Feb", "Mar", "Apr", "May",
                                                       "June",
                                                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
                                        c(rep("winter", 2), rep("spring", 3), rep("summer", 3), 
                                          rep("fall", 3), "winter")))

# create weekend variables
crashes <- transform(crashes,
                     day.type = mapvalues(DAY_OF_WEEK, c("Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"),
                                          c("weekend", rep("weekday", 5), "weekend")))


# smaller dataframe
crashes.smaller <- select(crashes, CRASH_CRN, DISTRICT, CRASH_YEAR, HOUR_OF_DAY, PERSON_COUNT,
                   VEHICLE_COUNT, BICYCLE_COUNT, FATAL_COUNT, MOD_INJ_COUNT, MIN_INJ_COUNT, 
                   BICYCLE_DEATH_COUNT, BICYCLE_MAJ_INJ_COUNT, PED_COUNT, PED_DEATH_COUNT, 
                   PED_MAJ_INJ_COUNT, LATITUDE, LONGITUDE, DEC_LAT, DEC_LONG, ALCOHOL_RELATED, 
                   DRINKING_DRIVER, CELL_PHONE, CROSS_MEDIAN, SPEEDING_RELATED,
                   AGGRESSIVE_DRIVING, FATIGUE_ASLEEP, NHTSA_AGG_DRIVING,
                   day.part, commute, season, day.type)

# After cleaning and creating new variables, subset bike and ped crashes
bikes <- subset(crashes, subset = BICYCLE==1)
ped <- subset(crashes, subset = COLLISION_TYPE==8)

# bike & ped subsets with fewer variables
bikes.smaller <- subset(crashes.smaller, subset = BICYCLE==1)
ped.smaller <- subset(crashes.smaller, subset = COLLISION_TYPE==8)

# subset fatal or severe crashes
crashes.major.fatal <- subset(crashes, subset = FATAL_OR_MAJ_INJ=="1")
bikes.major <- subset(crashes.major.fatal, subset = BICYCLE==1)
ped.major <- subset(crashes.major.fatal, subset = COLLISION_TYPE==8)


### Write out to .csv
# can replace 'crashes.smaller' with whatever dataframe you want
write.table(crashes.smaller, file="your_file_name.csv", row.names = F, col.names = T, sep=",")
