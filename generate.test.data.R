generate.test.data <- function(data, intervals) {
#   lapply(data, function(col) {
    lapply(intervals, function(interval) {
      diff(data$eurjpy, interval)
    })
#   })
}

generate.test.data.data <- data.frame(eurjpy = c(0,1,2,3,4,5,6,7,8,9), usdjpy = c(9,8,7,6,5,4,3,2,1,0))
generate.test.data.intervals <- c(2, 2)
result <- generate.test.data(generate.test.data.data, generate.test.data.intervals)
result