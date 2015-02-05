##Determine which rows to read, minutes=rows
date1 <- as.POSIXlt("2006-12-16 17:24:00")
date2 <- as.POSIXlt("2007-02-01 00:00:00")
date3 <- as.POSIXlt("2007-02-02 23:59:00")

#number of minutes between first time pt in data set & 2/1/07 0:00 exclusive
skip <- (date2-date1)*1440 #1440 minutes in 1 day
skip <- as.numeric(skip)+1 #+1 b/c diff not inclusive of end dates

#number of minutes between dates of interest
nrow <- (date3-date2)*1440 
nrow <- as.numeric(nrow)+1 

##Read Data
fn = "household_power_consumption.txt"
sep = ";"
col <- c("Date","Time","Global_active_power",
         "Global_reactive_power","Voltage","Global_intensity",
         "Sub_metering_1","Sub_metering_2","Sub_metering_3")
dat <- read.table(fn, sep=sep, header=FALSE, skip=skip,
                  nrow=nrow,na.strings="?",col.names=col)

##Get weekdays
#data in format dd/mm/yyyy hr:min:sec
days <- strptime(paste(dat$Date, dat$Time),"%d/%m/%Y %H:%M:%S") 

##Plot plot2
##Png has transparent background; can remove bg="transparent" to get white background
png("plot2.png", height=480, width=480, bg="transparent")
plot(days, dat$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
