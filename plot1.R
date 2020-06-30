# Initialize ---------------------------------------------------------------

rm(list = ls())

library(data.table)
library(lubridate, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)

file <- "household_power_consumption.txt"
power <- fread(file = file, na.strings = "?")


# Filter by date ----------------------------------------------------------

power <- power %>%
         unite(Date, Time, sep = " ", col = "Date_time") %>% # ou mutate(Date_time = str_c(Date, Time))
         mutate(Date_time = dmy_hms(Date_time)) %>%
         filter(Date_time >= as.Date("2007-02-01") & Date_time < as.Date("2007-02-03") )


# Plot --------------------------------------------------------------------

png(filename = "plot1.png")
hist(power$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     col = "red")
dev.off()



