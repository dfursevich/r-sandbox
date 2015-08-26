data <- read.csv("EURUSD_hour.csv", 
                      colClasses =c(rep("character", 3), rep("numeric", 4)), 
                      col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low

output <- aggregate(maxDelta ~ time, data, mean)
# output[order(output$maxDelta),]
output