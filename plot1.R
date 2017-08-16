plot1 <- function(file_path){
  ## plot1.png Related to this plot
  
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
  consumptionRecords <- read.table(text = cleanFile, sep = ";", header = TRUE, col.names = namesVector)
  
  ## Create plot 1
  hist(consumptionRecords$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
  consumptionRecords
}