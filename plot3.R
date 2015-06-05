library(data.table)

# data file name, in the current working directory
fName <- "household_power_consumption.txt"
# first date of data required
firstDate <- "1/2/2007"
# number of days of data required
nDays <- 2
# one row per second - number of rows of data
nRows <- nDays * 24 * 60
# na's coded as
nas <- "?"

# get the column names
DTab <- fread(fName,nrows=0)
colNames <- names(DTab)
# read the required data and add the column names
DTab <- fread(fName,nrows=nRows,skip=firstDate,na.strings=nas)
setnames(DTab,colNames)
# create a date/time object from the date & time text variables
DateTime <- strptime(paste(DTab$Date,DTab$Time),format="%d/%m/%Y %H:%M:%S")

# set up the plot details
xLab <- ""
yLab <- "Energy sub metering"

# open the png file device at default 480x480 size, in the current working directory
pName <- "plot3.png"
png(filename=pName)

# plot the line plot to the png file
# Sub_metering_1, default col black, then add 2 & 3, red & blue
with(DTab,plot(DateTime,Sub_metering_1,xlab=xLab,ylab=yLab, type="l"))
with(DTab,lines(DateTime,Sub_metering_2, col="red"))
with(DTab,lines(DateTime,Sub_metering_3, col="blue"))
# add the legend
legend("topright",col=c("black","red","blue"),legend=paste0("Sub_metering_",1:3),lty=1)

# close the png file
dev.off()
