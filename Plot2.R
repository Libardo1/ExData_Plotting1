source("Preprocess.R")

doPlot2 <- function() {
    tbl <- prepareData()
    png(filename = "plot2.png", width = 480, height = 480, units = "px")
    plot(tbl$DateTime, tbl$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    dev.off()
}

doPlot2()
