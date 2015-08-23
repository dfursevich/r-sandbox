data <- head(read.csv("EURUSD_hour.csv", colClasses ="character"),100000)
firstRow = data[1, ]
firstRow["DELTA"] <- format(0, scientific=FALSE, nsmall=4)
firstRow["LONG_DELTA"] <- format(0, scientific=FALSE, nsmall=4) 
firstRow["TREND"] <- format(0, scientific=FALSE, nsmall=4)
firstRow["MAX_TREND"] <- format(0, scientific=FALSE, nsmall=4)


longDelta <- 0
trend <- 0
trendMax <- 0
output = lapply(2:nrow(data), function(i) {
  currentRow <- data[i,]  
  prevRow <- data[i-1,]
  
  delta <- as.numeric(currentRow["X.OPEN."]) - as.numeric(prevRow["X.OPEN."])
  
  if (longDelta * delta >= 0) {
    longDelta <<- longDelta + delta      
  } else {
    longDelta <<- delta      
  }    
  
  if (trend * delta >= 0) {
    trend <<- trend + delta            
  } else {
    trend <<- trend + delta
    if ((trendMax - trend) / trendMax > 0.2) {
      trend <<- delta      
      trendMax <<- trend
    }      
  }      
  
  if (abs(trend) > abs(trendMax)) {
    trendMax <<- trend
  }
  
  currentRow["DELTA"] <- format(delta, scientific=FALSE, nsmall=4,justify = "right", width=7)
  currentRow["LONG_DELTA"] <- format(longDelta, scientific=FALSE, nsmall=4,justify = "right", width=7) 
  currentRow["TREND"] <- format(trend, scientific=FALSE, nsmall=4,justify = "right", width=7)
  currentRow["MAX_TREND"] <- format(trendMax, scientific=FALSE, nsmall=4,justify = "right", width=7)
  currentRow["MAX_TREND_ABS"] <- format(abs(trendMax), scientific=FALSE, nsmall=4,justify = "right", width=6)
  currentRow
})

output = do.call(rbind, output)
write.csv(output, file = "EURUSD_hour_output.csv", row.names = FALSE)