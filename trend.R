require(gdata)

data <- read.csv("EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

# data <- head(data, 20)

data$delta <- data$close - data$open

longDelta <- 0
trend <- 0
trendMax <- 0
output = by(data, 1:nrow(data), function(row) {  
  
  if (longDelta * row$delta >= 0) {
    longDelta <<- longDelta + row$delta      
  } else {
    longDelta <<- row$delta      
  }    
  
  if (trend * row$delta >= 0) {
    trend <<- trend + row$delta            
  } else {
    trend <<- trend + row$delta
    if ((trendMax - trend) / trendMax > 0.2) {
      trend <<- row$delta      
      trendMax <<- trend
    }      
  }      
  
  if (abs(trend) > abs(trendMax)) {
    trendMax <<- trend
  }
  
  row$longDelta = longDelta
  row$trend = trend
  row$trendMax = trendMax  
  row
})

output = do.call(rbind, output)

write.fwf(output, file = "trend_output.csv")