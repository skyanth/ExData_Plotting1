### this prepares the dataset
# read file
household_power_consumption <- read.csv("~/Workspace/Coursera_Data_Science/exploratorydataanalysis/project1/household_power_consumption.txt", sep=";", na.strings = c("?",""))

# subset on date
selected_data <- household_power_consumption[(household_power_consumption$Date=="1/2/2007" | household_power_consumption$Date=="2/2/2007"),]
# add datetime column for easy plotting
selected_data$datetime <- strptime(paste(selected_data$Date, selected_data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")


### this actually produces the plot
# open device
png(file="plot4.png")

# set placement
par(mfrow=c(2,2))

# upper left
with(selected_data, plot(datetime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# upper right
with(selected_data, plot(datetime, Voltage, type="l"))

# lower left
with(selected_data, plot(datetime, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab=""))
lines(selected_data$datetime, selected_data$Sub_metering_1)
lines(selected_data$datetime, selected_data$Sub_metering_2, col="red")
lines(selected_data$datetime, selected_data$Sub_metering_3, col="blue")
legend('topright', lty=1, col=c('black', 'red', 'blue'), legend=names(selected_data[c(7,8,9)]), bty="n")

# lower right
with(selected_data, plot(datetime, Global_reactive_power, type="l"))

# close device
dev.off()
