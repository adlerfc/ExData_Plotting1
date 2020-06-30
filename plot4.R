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

png(filename = "plot4.png")
par(mfcol = c(2, 2))
with(power, {
        
        # 1,1
        plot(Global_active_power ~ Date_time, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
        
        # 2,1
        plot(Sub_metering_1 ~ Date_time, xlab = "", ylab = "Energy sub metering", type = "l") 
        lines(Sub_metering_2 ~ Date_time, col = "red")
        lines(Sub_metering_3 ~ Date_time, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                lwd = 1, col = c("black", "blue", "red"), bty = "n", cex = 0.8)
        
        # 1,2
        plot(Voltage ~ Date_time, xlab = "datetime", ylab = "Voltage", type = "l")
        
        # 2,2
        plot(Global_reactive_power ~ Date_time, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
     }
)

dev.off()



