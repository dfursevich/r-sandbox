test.indicators <- function(indicators, data, test.data, test.intervals, lot = 1000) {
  lapply(test.intervals, function(interval) {  
    interval.result.matrix <- sapply(seq_along(indicators), function(col_index) {
      currency.name <- names(indicators[col_index])
      currency.indicators <- indicators[, col_index]
      currency.data <- data[, currency.name]
      currency.test.data <- test.data[, paste(currency.name, interval, sep = ".")]
      ifelse(is.na(currency.indicators), NA, (currency.test.data - currency.data) * lot * sign(currency.indicators))      
    })
    
    interval.result.df <- as.data.frame(interval.result.matrix);
    interval.result.names <- lapply(names(indicators), function(indicator.name) {
      paste(indicator.name, interval, sep = ".")
    })    
    names(interval.result.df) <- interval.result.names
    interval.result.df
  })
}

test.indicators.indicators <- data.frame(eurjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1), usdjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1))
test.indicators.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55), usdjpy = c(1,3,6,10,15,21,28,36,45,55))
test.indicators.test.data <- data.frame(eurjpy.2 = c(6,10,15,21,28,36,45,55,NA,NA), eurjpy.5 = c(21,28,36,45,55,NA,NA,NA,NA,NA), usdjpy.2 = c(6,10,15,21,28,36,45,55,NA,NA), usdjpy.5 = c(21,28,36,45,55,NA,NA,NA,NA,NA))
test.indicators.test.intervals <- c(2,5)
test.indicators.lot <- 1
test.indicators.result <- test.indicators(test.indicators.indicators, test.indicators.data, test.indicators.test.data, test.indicators.test.intervals, test.indicators.lot)
do.call(cbind.data.frame, test.indicators.result)
