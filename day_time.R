require(gdata)

data <- read.csv("input/EURUSD_hour.csv", 
                      colClasses =c(rep("character", 3), rep("numeric", 4)), 
                      col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

# data <- head(data, 20000)

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low

output <- aggregate(maxDelta ~ format(date, "%Y") + time, data, mean)
names(output)[1]<-"year"
output <- xtabs(maxDelta ~ time + year, data = output)
# output[order(output$maxDelta),]
write.fwf(output, file = "output/day_time_output.csv")