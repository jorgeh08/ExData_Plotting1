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
##3rd, converts to column 1 and 2 to specific Date and Time formats##
data01$Date <- as.Date(data01$Date,"%d/%m/%Y")
data01$Time <- strptime(data01$Time,"%T")

##4th, prompts for the Initial and Final Date of the time frame##
ini_d <- readline(prompt = "Enter the initial date for the chart (in format yyyy-mm-dd ) : ")
end_d <- readline(prompt = "Enter the final date for the chart (in format yyyy-mm-dd ) : ")

##5th, subsets the time frame to the specific time frame##
data02 <- data01[((data01$Date >= as.Date(ini_d))&(data01$Date <= as.Date(end_d))), ]

##6th, generates the plot##
hist(data02$Global_active_power, breaks =24, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

##7th, creates and output file##
dev.copy(png, file = "plot1.png")
dev.off()
