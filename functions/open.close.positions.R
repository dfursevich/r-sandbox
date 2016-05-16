open.close.positions <- function(indicators, data, test.data, test.indicators, stop.loss = 0.1, take.profit = 1) {
  interval.result.list <- lapply(seq_along(indicators), function(col_index) {
    currency.name <- names(indicators[col_index])
    currency.indicators <- indicators[, col_index]
    currency.data <- data[, currency.name]
    currency.test.data <- test.data[[currency.name]]
    currency.test.indicators <- test.indicators[[currency.name]]
    
    sapply(1:length(currency.indicators), function(row_index){
      currency.indicators.value <- currency.indicators[row_index]
      if (is.na(currency.indicators.value) || currency.indicators.value == 0) {
        return(NA)
      }
      currency.value <- as.numeric(currency.data[row_index])
      currency.test.data.values <- as.numeric(currency.test.data[row_index, ])
      currency.test.indicator.values <- as.numeric(currency.test.indicators[row_index, ])
      
      best.test.value <- currency.value
      sign <- sign(currency.indicators.value)
      for (i in 1:length(currency.test.data.values)) {
        test.value <- currency.test.data.values[i]
        indicator.value <- currency.test.indicator.values[i]
        if (is.na(test.value) || is.na(indicator.value)) {
          next
        }
        if (sign * (test.value - best.test.value) > 0) {
          if (sign * (test.value - currency.value) >= take.profit) {
            return(sign * (test.value - currency.value))
          } else if ((sign * indicator.value) > 0) {
            return(sign * (test.value - currency.value))
          } else {
            best.test.value <- test.value  
          }
        } else {
          if (sign * (best.test.value - test.value) >= stop.loss) {
            return(sign * (test.value - currency.value))
          } else if ((sign * indicator.value) < 0) {
            return(sign * (test.value - currency.value))
          }
        }
      }
      sign * (test.value - currency.value)
    })
  })
  names(interval.result.list) <- names(indicators)
  interval.result.list
}
open.close.positions.indicators <- data.frame(eurjpy = c(0,NA,1,1,1,1,-1,-1,-1,-1), usdjpy = c(0,NA,1,1,1,1,-1,-1,-1,-1))
open.close.positions.data <- data.frame(eurjpy = c(NA,NA,10,10,10,10,10,10,10,10), usdjpy = c(NA,NA,10,10,10,10,10,10,10,10))
open.close.positions.test.data <- list(eurjpy = data.frame('2' = c(NA,NA,11,11,9,11,9,9,9,NA), '4' = c(NA,NA,12,20,8,9,8,11,10,NA), '6' = c(NA,NA,13,21,7,10,7,10,8,NA), check.names=FALSE), usdjpy=data.frame('2' = c(NA,NA,11,11,9,11,9,9,9,NA), '4' = c(NA,NA,12,20,8,9,8,11,10,NA), '6' = c(NA,NA,13,21,7,10,7,10,8,NA), check.names=FALSE))
open.close.positions.test.indicators <- list(eurjpy = data.frame('2' = c(NA,NA,11,11,9,11,9,9,9,NA), '4' = c(NA,NA,12,20,8,9,8,11,10,NA), '6' = c(NA,NA,13,21,7,10,7,10,8,NA), check.names=FALSE), usdjpy=data.frame('2' = c(NA,NA,11,11,9,11,9,9,9,NA), '4' = c(NA,NA,12,20,8,9,8,11,10,NA), '6' = c(NA,NA,13,21,7,10,7,10,8,NA), check.names=FALSE))
open.close.positions.result <- open.close.positions(open.close.positions.indicators, open.close.positions.data, open.close.positions.test.data, open.close.positions.test.indicators, 2, 10)
do.call(cbind.data.frame, open.close.positions.result)
setequal(do.call(cbind.data.frame, open.close.positions.result), data.frame(eurjpy = c(NA,NA,3,10,-2,-1,3,-1,2,NA), usdjpy = c(NA,NA,3,10,-2,-1,3,-1,2,NA)))