data <- head(read.csv("EURUSD_hour.csv", colClasses ="character"), 100)

trendDelta <- 0
delta <- 0
trendTurnPercent <- 0
output = lapply(1:nrow(data), function(i) {
  currentRow <- data[i,]
  if (i > 1) {
    prevRow <- data[i-1,]
    delta <- as.numeric(currentRow["X.OPEN."]) - as.numeric(prevRow["X.OPEN."])
    
    print(delta, scientific=FALSE)
    print(trendDelta, scientific=FALSE)
    
    if (trendDelta * delta >= 0) {
      trendDelta <<- trendDelta + delta
      trendTurnPercent <- 0
    } else {
      #turn
      trendTurnPercent <- -100 * delta/trendDelta
      trendDelta <<- delta      
    }          
  }  
  currentRow["X.DELTA."] <- format(delta, scientific=FALSE, nsmall=4)
  currentRow["X.TREND_DELTA."] <- format(trendDelta, scientific=FALSE, nsmall=4)
  currentRow["X.TREND_TURN_PERCENT."] <- format(round(trendTurnPercent, 2), scientific=FALSE, nsmall=2)
  currentRow
})

output = do.call(rbind, output)
output