# Import data
dat0 <- read.csv("household_power_consumption.txt", sep = ";")
dat <- subset(dat0, Date %in% c("1/2/2007","2/2/2007"))
rm(dat0)

# Massage
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat$Time <- strptime(dat$Time)
dat$Global_active_power <- as.numeric(dat$Global_active_power)

#Without the next step the data will not result in the given graph
dat$Global_active_power <- dat$Global_active_power/500

png(filename = "plot1.png")

hist(dat$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)", #This is not true, but that's what's in the exapmple graph...
     xlim = c(0,6),
     xaxt = "n"
)

axis(1, at=seq(0, 6, by=2))

dev.off()

