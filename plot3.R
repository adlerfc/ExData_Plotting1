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

png(filename = "plot3.png")
with(power, {
     plot(Sub_metering_1 ~ Date_time, xlab = "", ylab = "Energy sub metering", type = "l") 
     lines(Sub_metering_2 ~ Date_time, col = "red")
     lines(Sub_metering_3 ~ Date_time, col = "blue")
     legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lwd = 1, col = c("black", "blue", "red"), cex = 0.8)
     }
)

dev.off()



