generate.test.data <- function(data, intervals) {
 list <- lapply(data, function(col) {
    intervals.list <- lapply(intervals, function(interval) {
      interval.diff <- diff(col, interval)      
      length(interval.diff) <- length(data$eurjpy)
      interval.diff
    })
   intervals.df <- do.call(cbind.data.frame, intervals.list)
   names(intervals.df) <- intervals
   intervals.df
 })
  do.call(cbind.data.frame, list)
}

generate.test.data.data <- data.frame(eurjpy = c(0,1,2,3,4,5,6,7,8,9), usdjpy = c(9,8,7,6,5,4,3,2,1,0))
generate.test.data.intervals <- c(2, 3, 4)
generate.test.data(generate.test.data.data, generate.test.data.intervals)