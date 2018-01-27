# Import data
dat0 <- read.csv("household_power_consumption.txt", sep = ";")
dat <- subset(dat0, Date %in% c("1/2/2007","2/2/2007"))
rm(dat0)

# Massage
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, "%d/%m/%Y %H:%M:%S")

dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Voltage <- as.numeric(dat$Voltage)

#Again, the data appears to be different from the data used to create the plot given as an example
dat$Global_active_power <- dat$Global_active_power/500
dat$Voltage <- dat$Voltage/100
dat$Voltage <- dat$Voltage + 225

dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)
dat$Sub_metering_1 <- dat$Sub_metering_1 - 1
dat$Sub_metering_2 <- dat$Sub_metering_2/5

dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Global_reactive_power <- dat$Global_reactive_power/480

png(filename = "plot4.png")

par(mfrow = c(2,2))

##Plot A
plot(dat$DateTime,dat$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global active power")

##Plot B
plot(dat$DateTime,dat$Voltage,
     type = "l",
     yaxt = "n",
     xlab = "datetime",
     ylab = "Voltage")

axis(2, at = seq(234, 246, by = 4))

##Plot C
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
       col = c("Black", "Red", "Blue"),
       bty = "n",
       cex = 1
)

##Plot D
plot(dat$DateTime,dat$Global_reactive_power,
     type = "l",
     ylim = c(0, 0.5),
     xlab = "datetime",
     ylab = "Global_reactive_power"
    )

dev.off()

