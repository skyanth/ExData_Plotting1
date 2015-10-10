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


### this actually produces the plot

# open device
png(file="plot1.png")

# draw histogram
hist(selected_data$Global_active_power, 
    main="Global Active Power", 
    xlab="Global Active Power (kilowatts)", 
    breaks=15, 
    col="red")

# close device
dev.off()