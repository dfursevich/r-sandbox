test.signals <- function(data, signals, test.intervals, test.data, lot) {
  list <- lapply(1:nrow(signals), function(row_index) {
    signal <- signals[row_index, ]
    
    data.value <- data[row_index, paste(signal$currency, '', sep='')]
    sapply(test.intervals, function(interval) {
      test.data.value <- test.data[row_index, paste(signal$currency, interval, sep = ".")] 
      
      (test.data.value - data.value) * lot * sign(signal$signal)
    })
  })
  
  result.df <- do.call(rbind.data.frame, list)
  names(result.df) <- test.intervals
  result.df
}

test.signals.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55))
test.signals.test.data <- data.frame(eurjpy.2 = c(6,10,15,21,28,36,45,55,NA,NA), eurjpy.5 = c(21,28,36,45,55,NA,NA,NA,NA,NA))
test.signals.signals <- data.frame(signal = c(0,1,2,3,4,5,6,7,8,9), currency=rep('eurjpy', 10))
test.signals.test.intervals <- c(2,5)
test.signals.lot <- 10
test.signals(test.signals.data, test.signals.signals, test.signals.test.intervals, test.signals.test.data, test.signals.lot)