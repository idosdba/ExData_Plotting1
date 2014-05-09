#####################################################################
# plot3(): Function to read in datafile and using a subset of data
# for 01.02 Feb, 2007, plot three graphs in the same plot.
# Saves the plot in a PNG file "plot3.png"
#####################################################################
plot3 <- function() {
  
      #read the data file
      allData <- read.table("household_power_consumption.txt",
                        header = T,
                        sep=';',
                        colClasses = "character",
                        stringsAsFactors = FALSE)
    
      # get subset of data for the two dates in feb 2007
      workData <- rbind(subset(allData, Date == "1/2/2007"),
                        subset(allData, Date == "2/2/2007"))
  
      # convert the Date, Time columns into a DateTime column in POSIX format
      workData$DateTime <- as.POSIXct(paste(workData$Date, workData$Time), 
                                      format="%d/%m/%Y %H:%M:%S")
  
      # convert sub_metering data to numeric
      workData$Sub_metering_1 <- as.numeric(workData$Sub_metering_1)
      workData$Sub_metering_2 <- as.numeric(workData$Sub_metering_2)
      workData$Sub_metering_3 <- as.numeric(workData$Sub_metering_3)
  
      # open a PNG device file
      png(file="plot3.png", bg = "white", 
              width = 480, height = 480, units = "px", pointsize = 12)
  
      # plot the graphs
      plot(workData$DateTime, workData$Sub_metering_1, 
             xlab = "", ylab = "Energy sub metering",
             type = "l", col = "black")
      lines(workData$DateTime, workData$Sub_metering_2, type = "l", col = "red")
      lines(workData$DateTime, workData$Sub_metering_3, type = "l", col = "blue")
      legend("topright", 
             lty = "solid", 
            col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
            )
  
      # close the PNG device
      dev.off()
}