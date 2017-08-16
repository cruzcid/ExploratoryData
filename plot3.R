plot3 <- function(file_path){
  ## plot3.png Related to this plot
  
  ## Vector of column names
  namesVector <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                   "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  ## Establish conection and read a file from given path. 
  rawFile <- file(file_path)
  rawLines <- readLines(rawFile)
  
  ## A regular expresion to filter "rawLines" 
  cleanFile <- grep("^[1-2]/2/2007", rawLines , value = TRUE)
  close(rawFile)
  
  ## Create the data frame with the desired content
  consumptionRecords <- read.table(text = cleanFile,na.strings = "?", sep = ";", header = TRUE, col.names = namesVector)
  
  
  # Handle Day convertion 
  consumptionDate <- as.Date(consumptionRecords$Date, format = "%d/%m/%Y")
  
  consumptionDateTime <- paste(consumptionDate, consumptionRecords$Time)
  
  consumptionDateTimeCST <- as.POSIXct(consumptionDateTime)
  
  consumptionRecords$DateTime <- consumptionDateTimeCST
  
  ## Create plot 3
  
  plot(consumptionRecords$Sub_metering_1~consumptionRecords$DateTime, type="l",xlab="", ylab = "Global Active Power (kilowatts)")
  lines(consumptionRecords$Sub_metering_2~consumptionRecords$DateTime, col="red")
  lines(consumptionRecords$Sub_metering_3~consumptionRecords$DateTime, col="blue")
  
  legend("topright", col=c("black","red","blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
}