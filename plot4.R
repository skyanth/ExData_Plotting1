### this prepares the dataset

# make sure that 
# - the working directory is set to the parent directory of this script 
#   (using setwd())
# - the downloaded file exdata-data-household_power_consumption.zip is in the 
#   same directory as the script

## Note: the instructions said to include code for *reading* the data. I took
## this to mean that code to *download* the data was not required.

# read file
hpc <- read.csv(
    # extract data from zip
    unz("exdata-data-household_power_consumption.zip", 
        "household_power_consumption.txt"),
    # other useful parameters for reading data
    sep=";", 
    na.strings = c("?","")
    )

# subset on date (we only need Feb 1 and 2, 2007)
selected_data <- hpc[(hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007"),]

# add datetime column for easy plotting
selected_data$datetime <- strptime(
    paste(selected_data$Date, selected_data$Time, sep=" "), 
    format="%d/%m/%Y %H:%M:%S")

### this actually produces the plot

# open device
png(file="plot4.png")

# configure placement
par(mfrow=c(2,2))

# upper left plot
with(selected_data, 
    plot(datetime, Global_active_power, 
        type="l", 
        ylab="Global Active Power", 
        xlab="")
    )

# upper right plot
with(selected_data, plot(datetime, Voltage, type="l"))

# lower left plot
with(selected_data, 
    plot(datetime, Sub_metering_1, 
        type="n", 
        ylab="Energy Sub Metering", 
        xlab="")
    )
lines(selected_data$datetime, selected_data$Sub_metering_1)
lines(selected_data$datetime, selected_data$Sub_metering_2, col="red")
lines(selected_data$datetime, selected_data$Sub_metering_3, col="blue")
legend('topright', 
    lty=1, 
    col=c('black', 'red', 'blue'), 
    legend=names(selected_data[c(7,8,9)]), 
    bty="n")

# lower right plot
with(selected_data, plot(datetime, Global_reactive_power, type="l"))

# close device
dev.off()