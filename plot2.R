# Import data
dat0 <- read.csv("household_power_consumption.txt", sep = ";")
dat <- subset(dat0, Date %in% c("1/2/2007","2/2/2007"))
rm(dat0)

# Massage
dat$DateTime <- paste(dat$Date, dat$Time)

dat$DateTime <- strptime(dat$DateTime, "%d/%m/%Y %H:%M:%S")

dat$Global_active_power <- as.numeric(dat$Global_active_power)

#Without the next step the data will not result in the given graph
dat$Global_active_power <- dat$Global_active_power/500

png(filename = "plot2.png")

plot(dat$DateTime,dat$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

axis(1, at=seq(0, 6, by=2))

dev.off()

