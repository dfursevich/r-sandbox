data <- read.csv("input/EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

data <- head(data, 20)

# data$delta <- data$close - data$open
# data$maxDelta <- data$high - data$low
# data$openDelta <- ifelse(data$delta >= 0, data$open - data$low, data$high - data$open)
# data$closeDelta <- ifelse(data$delta >= 0, data$high - data$close, data$close - data$low)

data$h1 = numeric(nrow(data))
data$h2 = numeric(nrow(data))
data$h3 = numeric(nrow(data))
data$h4 = numeric(nrow(data))

output <- lapply(1:nrow(data), function(i) {
  row = data[i, ]
  if (i >= 5) {  
    row1h = data[i - 1, ]
    row2h = data[i - 2, ]
    row3h = data[i - 3, ]
    row4h = data[i - 4, ]
    
    row$h1 = row$close - row1h$close
    row$h2 = row$close - row2h$close
    row$h3 = row$close - row3h$close
    row$h4 = row$close - row4h$close  
  }
  row
})

output <- do.call(rbind, output)
output