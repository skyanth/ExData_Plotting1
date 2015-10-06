### this prepares the dataset
# read file
household_power_consumption <- read.csv("~/Workspace/Coursera_Data_Science/exploratorydataanalysis/project1/household_power_consumption.txt", sep=";", na.strings = c("?",""))

# subset on date
selected_data <- household_power_consumption[(household_power_consumption$Date=="1/2/2007" | household_power_consumption$Date=="2/2/2007"),]
# add datetime column for easy plotting
selected_data$datetime <- strptime(paste(selected_data$Date, selected_data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")


### this actually produces the plot
png(file="plot2.png")
with(selected_data, plot(datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
