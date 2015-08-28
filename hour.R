require(gdata)

data <- read.csv("EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

# data <- head(data, 20000)

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low
data$openDelta <- ifelse(data$delta >= 0, data$open - data$low, data$high - data$open)
data$closeDelta <- ifelse(data$delta >= 0, data$high - data$close, data$close - data$low)
#1-openDelta and closeDelta eash less then 25% of maxDelta, 
#2-openDelta less then 25% of maxDelta
#3-closeDelta less then 25% of maxDelta
#4-others
data$class <- ifelse(data$openDelta/data$maxDelta <= 0.25 & data$closeDelta/data$maxDelta <= 0.25, 1, 
              ifelse(data$openDelta/data$maxDelta <= 0.25, 2, 
              ifelse(data$closeDelta/data$maxDelta <= 0.25, 3, 4)))
output <- aggregate(cur ~ format(date, "%Y") + class, data, length)
names(output)[1]<-"year"
output <- xtabs(cur ~ class + year, data = output)
write.fwf(output, file = "hour_output.csv")