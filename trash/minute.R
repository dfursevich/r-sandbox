require(gdata)

data <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv")
names(data) <- c("date", "time", "open", "low", "high", "close", "xz")
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 
data$xz <- NULL

data <- head(data, 30000)

intervals <- seq(from = 15, by = 15, length.out = 12)

for(int in intervals) {
  data[paste0("m", int)] = numeric(nrow(data))
  
  data <- lapply(1:nrow(data), function(i) {
    row = data[i, ]      
    
    dataInt = data[ifelse(i > int, i - int, 0) : (i - 1), ]  
    rowInt = dataInt[difftime(row$date, dataInt$date, units = "min") == int, ]    
    row[paste0("m", int)] = ifelse(nrow(rowInt) == 1, row$close - rowInt$close, NA)       
    
    row
  })  
  
  data <- do.call(rbind, data)  
}

data$date <- format(data$date, "%Y.%m.%d %H:%M")

write.fwf(data, file = "output/minute_output.csv")