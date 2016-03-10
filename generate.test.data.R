generate.test.data <- function(data, intervals) {
 list <- lapply(seq_along(data), function(col_index) {
   col <- data[, col_index]
   intervals.list <- lapply(intervals, function(interval) {
      interval.diff <- (-1) * diff(col, interval)      
      length(interval.diff) <- length(data$eurjpy)
      interval.diff
    })
   intervals.df <- do.call(cbind.data.frame, intervals.list)
   intervals.names <- lapply(intervals, function(interval) {
     paste(names(data[col_index]), interval, sep = ".")
   })
   names(intervals.df) <- unlist(intervals.names)
   intervals.df
 })
 do.call(cbind.data.frame, list)
}

generate.test.data.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55), usdjpy = c(10,19,27,34,40,45,49,52,54,55))
generate.test.data.intervals <- c(2)
generate.test.data(generate.test.data.data, generate.test.data.intervals)