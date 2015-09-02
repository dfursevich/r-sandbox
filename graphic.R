data <- read.csv("input/EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

data <- head(data, 5)
data

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low
data$openDelta <- ifelse(data$delta >= 0, data$open - data$low, data$high - data$open)
data$closeDelta <- ifelse(data$delta >= 0, data$high - data$close, data$close - data$low)

output = data.frame("h" = numeric(), "hh" = numeric())

for(i in 1:(nrow(data) - 5)) {
  row = data[i + 5, ]
  row1h = data[(i - 4), ]
  row2h = data[(i - 3), ]
  
  output$h[i] = row$close - row1h$close  
  output$hh[i] = row$close - row2h$close  
}

output


