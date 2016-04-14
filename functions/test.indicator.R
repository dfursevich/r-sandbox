test.indicator <- function(data, test.intervals, test.data, lot = 1000) {
  if (length(data) == 1){
    list <- lapply(1:nrow(data), function(row_index) {
      signal <- signals[row_index, ]
      
      data.value <- data[row_index, paste(signal$currency, '', sep='')]
      sapply(test.intervals, function(interval) {
        test.data.value <- test.data[row_index, paste(signal$currency, interval, sep = ".")] 
        ifelse(is.null(data.value), NA, (test.data.value - data.value) * lot * sign(signal$signal))      
      })
    })
    
    result.df <- do.call(rbind.data.frame, list)
    names(result.df) <- test.intervals
    result.df  
  } else {
    
  }  
  
  lapply(data, function(coll){
    
  })
}

test.indicator.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55))
test.indicator.test.data <- data.frame(eurjpy.2 = c(6,10,15,21,28,36,45,55,NA,NA), eurjpy.5 = c(21,28,36,45,55,NA,NA,NA,NA,NA))
test.indicator.test.intervals <- c(2,5)
test.indicator.lot <- 10
test.indicator(test.signals.data, test.signals.signals, test.signals.test.intervals, test.signals.test.data, test.signals.lot)