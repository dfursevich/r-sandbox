open.close.positions <- function(indicators, data, test.data, stop.loss = 0.001, take.profit = 0.001) {
  interval.result.list <- lapply(seq_along(indicators), function(col_index) {
    currency.name <- names(indicators[col_index])
    currency.indicators <- indicators[, col_index]
    currency.data <- data[, currency.name]
    currency.test.data <- test.data[[currency.name]]
    
    sapply(1:length(currency.indicators), function(row_index){
      currency.indicators.value <- currency.indicators[row_index]
      currency.value <- currency.data[row_index]
      for (test.value in currency.test.data[row_index, ]) {
        income <- (test.value - currency.value) * sign(currency.indicators.value)
        return(income)
      }
    })
  })
  names(interval.result.list) <- names(indicators)
  interval.result.list
}

open.close.positions.indicators <- data.frame(eurjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1), usdjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1))
open.close.positions.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55), usdjpy = c(1,3,6,10,15,21,28,36,45,55))
open.close.positions.test.data <- list(eurjpy = data.frame('2' = c(6,10,15,21,28,36,45,55,NA,NA), '5' = c(21,28,36,45,55,NA,NA,NA,NA,NA), check.names=FALSE), usdjpy=data.frame('2' = c(6,10,15,21,28,36,45,55,NA,NA), '5' = c(21,28,36,45,55,NA,NA,NA,NA,NA), check.names=FALSE))
open.close.positions.result <- open.close.positions(open.close.positions.indicators, open.close.positions.data, open.close.positions.test.data)

do.call(cbind.data.frame, open.close.positions.result)