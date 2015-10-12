##1st, checks if the file was downloaded##
if(!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "hpc.zip")
        unzip("hpc.zip")
        data01 <- read.table("household_power_consumption.txt",header=TRUE, sep=";", na.strings = "?")
}
##2nd, checks if the dataframe was created##
if(!exists("data01")){
        data01 <- read.table("household_power_consumption.txt",header=TRUE, sep=";", na.strings = "?")
}
##3rd, converts to column 1 to specific Date formats##
data01$Date <- as.Date(data01$Date,"%d/%m/%Y")

##4th, prompts for the Initial and Final Date of the time frame##
ini_d <- readline(prompt = "Enter the initial date for the chart (in format yyyy-mm-dd ) : ")
end_d <- readline(prompt = "Enter the final date for the chart (in format yyyy-mm-dd ) : ")

##5th, subsets the time frame to the specific time frame##
data02 <- data01[((data01$Date >= as.Date(ini_d))&(data01$Date <= as.Date(end_d))), ]
data02$time_stamp <- paste(data02$Date, data02$Time, sep=" ")
data02$time_stamp <- strptime(data02$time_stamp, format = "%Y-%m-%d %H:%M:%S")

##6th, generates the plot##
png("plot2.png", width = 480, height = 480)
plot(data02$time_stamp, data02$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
