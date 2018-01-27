# Import data
dat0 <- read.csv("household_power_consumption.txt", sep = ";")
dat <- subset(dat0, Date %in% c("1/2/2007","2/2/2007"))
rm(dat0)

# Massage
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, "%d/%m/%Y %H:%M:%S")

dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

#Again, the data appears to be different from the data used to create the plot given as an example
dat$Sub_metering_1 <- dat$Sub_metering_1 - 1
dat$Sub_metering_2 <- dat$Sub_metering_2/5

png(filename = "plot3.png")

plot(dat$DateTime,dat$Sub_metering_1,
     type = "l",
     ylim = c(0, 33),
     yaxt = "n",
     xlab = "",
     ylab = "Energy sub metering")

par(new = TRUE)

plot(dat$DateTime,dat$Sub_metering_2,
     type = "l",
     ylim = c(0, 33),
     yaxt = "n",
     col = "Red",
     xlab = "",
     ylab = "Energy sub metering")

par(new = TRUE)

plot(dat$DateTime,dat$Sub_metering_3,
     type = "l",
     ylim = c(0, 33),
     yaxt = "n",
     col = "Blue",
     xlab = "",
     ylab = "Energy sub metering"
     )

axis(2, at = seq(0, 33, by = 10))

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("Black", "Red", "Blue")
       )

dev.off()

