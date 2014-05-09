#################################################################
# plot1() : Function to read in the data file data for two
# days 01,02 Feb, 2007 and for that data
# plots a graph of Date vs. Global active power. 
# Saves the graph in a PNG device file "plot1.png"
#################################################################
plot1 <- function() {
      
      #read the data file
      allData <- read.table("household_power_consumption.txt",
                            header = T,
                            sep=';',
                            colClasses = "character",
                            stringsAsFactors = FALSE)
            
      # get the subset for the two dates 
      workData <- rbind(subset(allData, Date == "1/2/2007"),
                        subset(allData, Date == "2/2/2007"))
      
      # convert the Date column into "Date" datatype
      workData$Date <- strptime(workData$Date, "%d/%m/%Y")
         
      # convert the Global_active_power to numeric
      workData$Global_active_power <- as.numeric(workData$Global_active_power)
      
      # Open a PNG file device
      png(file="plot1.png", bg = "white", 
          width = 480, height = 480, units = "px", pointsize = 12)
            
      #plot the graph
      hist(workData$Global_active_power,
             col = "red",
             main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)", 
             ylab = "Frequency")
      
      # Close the device
      dev.off()
}