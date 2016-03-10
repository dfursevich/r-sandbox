test.signals <- function(data, signals, test.intervals, test.data) {
  lapply(1:nrow(signals), 1, function(row_index) {
    signal <- signals[row_index, ]
#     lapply(test.intervals, function(test.interval) {
#         
#     })
    
    test.value <- test.data[row_index, paste(signal$currency, 2, sep = "")] 
    
  })
}

test.signals.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55))
test.signals.test.data <- data.frame(eurjpy.2 = c(-5,-7,-9,-11,-13,-15,-17,-19,NA,NA))
test.signals.signals <- data.frame(signal = c(0,1,2,3,4,5,6,7,8,9), currency=rep('eurjpy', 10))
test.signals.test.intervals <- c(2)
test.signals(test.signals.data, test.signals.test.data, test.signals.test.intervals, test.signals.signals)