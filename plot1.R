## plot1.R

## reading data into R
if(!file.exists("exdata_data_household_power_consumption.zip")) {
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, "exdata_data_household_power_consumption.zip", method="curl")
}
if(!file.exists("household_power_consumption.txt")){
        unzip("exdata_data_household_power_consumption.zip")
}
headers <- read.table(file="household_power_consumption.txt",sep = ";",nrows=1)
dat <- read.table(file = "household_power_consumption.txt", 
                       sep=";",
                       skip=66637, 
                       nrows=2880)
colnames(dat) <- headers
dat[dat=="?"] <- NA

## creating plot and saving as PNG
png(filename="plot1.png",width=480,height=480,units="px")
hist(dat$Global_active_power,
     ylab="Frequency",
     xlab="Global Active Power (kilowatts)",
     col="red",
     main="Global Active Power")
dev.off()