## plot4.R

## reading data into R
if(!file.exists("exdata_data_household_power_consumption.zip")) {
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, "exdata_data_household_power_consumption.zip", method="curl")
}
if(!file.exists("household_power_consumption.txt")){
        unzip("exdata_data_household_power_consumption.zip")
}
dat_full <- read.table(file = "household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")
dat <- subset(dat_full,Date%in%c("1/2/2007","2/2/2007"))
dat$Global_active_power <- as.numeric(dat$Global_active_power)

## date time manipulation
dat$Date <- as.Date(dat$Date,format="%d/%m/%Y")
dat$datetime <- as.POSIXct(strptime(paste(dat$Date,dat$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S"))

## creating plot and saving as PNG
png(filename="plot4.png",height=480,width=480,units="px")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dat, {
        plot(Global_active_power~datetime, 
             type="l", 
             ylab="Global Active Power", 
             xlab="")
        plot(Voltage~datetime, 
             type="l", 
             ylab="Voltage", 
             xlab="")
        plot(Sub_metering_1~datetime, 
             type="l", 
             ylab="Energy sub metering", 
             xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n")
        plot(Global_reactive_power~datetime, 
             type="l", 
             ylab="Global_reactive_power",xlab="")
})
dev.off()
