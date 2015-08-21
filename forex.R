data <- head(read.csv("EURUSD_hour.csv", colClasses ="character"))

trendDelta <- 0
delta <- 0
output = lapply(1:nrow(data), function(i) {
  currentRow <- data[i,]
  if (i > 1) {
    prevRow <- data[i-1,]
    delta <- as.numeric(currentRow["X.OPEN."]) - as.numeric(prevRow["X.OPEN."])
    
    print(delta, scientific=FALSE)
    print(trendDelta, scientific=FALSE)
    
    if (trendDelta * delta >= 0) {
      trendDelta <<- trendDelta + delta
    } else {
      trendDelta <<- delta
    }          
  }  
  currentRow["X.DELTA."] <- format(delta, scientific=FALSE)
  currentRow["X.TREND_DELTA.<- format(trendDelta, scientific=FALSE)
  currentRow
})

output = do.call(rbind, output)
output