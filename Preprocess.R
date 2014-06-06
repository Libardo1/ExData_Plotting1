library(grDevices) #required for png file

Sys.getlocale() #change my lotal time to english
#[1] "LC_COLLATE=Spanish_Colombia.1252;LC_CTYPE=Spanish_Colombia.1252;LC_MONETARY=Spanish_Colombia.1252;LC_NUMERIC=C;LC_TIME=Spanish_Colombia.1252"
Sys.setlocale("LC_TIME", "C")
[1] "C"
Sys.getlocale()
#[1] "LC_COLLATE=Spanish_Colombia.1252;LC_CTYPE=Spanish_Colombia.1252;LC_MONETARY=Spanish_Colombia.1252;LC_NUMERIC=C;LC_TIME=C"


dnldfile <- function(fileURL, fname) {
    if(!file.exists(fname)) {
        download.file(fileURL, destfile=fname)
    }
    fname
}

prepareData <- function() {
    cacheFile <- "plot_data.csv"
    if(file.exists(cacheFile)) {
        tbl <- read.csv(cacheFile)
        tbl$DateTime <- strptime(tbl$DateTime, "%Y-%m-%d %H:%M:%S", tz = "C")
    }
    else {
        fname <- dnldfile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
        con <- unz(fname, "household_power_consumption.txt")
        tbl <- read.table(con, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
        
        tbl <- tbl[(tbl$Date == "1/2/2007") | (tbl$Date == "2/2/2007"),]
        tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time), "%d/%m/%Y %H:%M:%S", tz = "C")
        write.csv(tbl, cacheFile)
    }
    tbl
    close(con)
}

