#######################################################################
# plot2(): Reads the data file and plots a graph of
# DateTime vs. Global Active Power with data for Feb 1-2, 2007.
# Saves the graph in a PNG device file "plot2.png"
#######################################################################
plot2 <- function() {
  
      #read the data file
      allData <- read.table("household_power_consumption.txt",
                            header = T,
                            sep=';',
                            colClasses = "character",
                            stringsAsFactors = FALSE)
      #allData
    
      workData <- rbind(subset(allData, Date == "1/2/2007"),
                        subset(allData, Date == "2/2/2007")
                      )

      workData$DateTime <- as.POSIXct(paste(workData$Date, workData$Time), 
                                      format="%d/%m/%Y %H:%M:%S")
        
      # first convert the Global_reactive_power to numeric
      workData$Global_active_power <- as.numeric(workData$Global_active_power)
      #workData
  
      # Open the PNG file device
      png(file="plot2.png", bg = "white", 
          width = 480, height = 480, units = "px", pointsize = 12)
      
      #plot the graph
      plot(workData$DateTime, 
           workData$Global_active_power, 
           type="l", 
           xlab="", 
           ylab="Global Active Power (kilowatts)")
  
      # Close the device
      dev.off()
      
}