generate.test.data <- function(data, intervals, flat = TRUE) {
 list <- lapply(seq_along(data), function(col_index) {
   col <- data[, col_index]
   intervals.matrix <- sapply(intervals, function(interval) {
      interval.shift <- col[(interval + 1):length(col)]     
      length(interval.shift) <- length(col)
      interval.shift
    })
   intervals.df <- data.frame(intervals.matrix)   
   names(intervals.df) <- intervals
   intervals.df
 })
 names(list) <- names(data) 
 
 if (flat) {
   do.call(cbind.data.frame, list)
 } else {
   list
 }
}

generate.test.data.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55), usdjpy = c(10,19,27,34,40,45,49,52,54,55))
generate.test.data.intervals <- c(2,4)
generate.test.data(generate.test.data.data, generate.test.data.intervals, FALSE)