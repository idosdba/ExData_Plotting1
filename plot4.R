####################################################################
# plot4(): Function to read data from a file and for a subset 
# of two days 01,02 Feb, 2007, plots four graphs.
# Saves the plot in a PNG file "plot4.png"
####################################################################
plot4 <- function() {
  
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
  
      # convert data to numeric
      workData$Global_active_power <- as.numeric(workData$Global_active_power)
      workData$Voltage <- as.numeric(workData$Voltage)
      workData$Sub_metering_1 <- as.numeric(workData$Sub_metering_1)
      workData$Sub_metering_2 <- as.numeric(workData$Sub_metering_2)
      workData$Sub_metering_3 <- as.numeric(workData$Sub_metering_3)
      workData$Global_reactive_power <- as.numeric(workData$Global_reactive_power)
    
      # open a PNG device file
      png(file="plot4.png", bg = "white", 
            width = 480, height = 480, units = "px", pointsize = 12)
  
      # plot the graphs in 2x2 layout
      par(mfrow = c(2,2))

      with(workData, {
            plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
            plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
            plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering",
                     type = "l", col = "black")
                lines(DateTime, Sub_metering_2, type = "l", col = "red")
                lines(DateTime, Sub_metering_3, type = "l", col = "blue")
                legend("topright", lty = "solid", bty = "n",
                       col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
            plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
      })
  
      # close the PNG device
      dev.off()
}
