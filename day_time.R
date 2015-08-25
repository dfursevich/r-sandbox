data <- head(read.csv("EURUSD_hour.csv", 
                      colClasses =c(rep("character", 3), rep("numeric", 4)), 
                      col.names = c("cur", "date", "time", "open", "low", "high", "close")),10)

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low

data