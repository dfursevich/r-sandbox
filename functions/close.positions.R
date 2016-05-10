open.close.positions <- function(indicators, data, test.data, stop.loss = 0.001, take.profit = 0.001) {
  interval.result.matrix <- sapply(seq_along(indicators), function(col_index) {
    currency.name <- names(indicators[col_index])
    currency.indicators <- indicators[, col_index]
    currency.data <- data[, currency.name]
    currency.test.data <- test.data[currency.name]
    #     currency.open.close.positions <- function(currency.indicators, currency.data, currency.test.data, stop.loss.percent, take.profit.percent) {
    #       close.position.results <- sapply(seq_along(currency.test.data), function(col_index) {
    #         currency.test.data.column <- currency.test.data[, col_index]
    #         close.position(currency.indicators, currency,data, currency.test.data.column, stop.loss.percent, take.profit.percent)
    #       })
    #             
    # #       for(row_index in 1:nrow(close.position.results)) {
    # #           row <- close.position.results[row_index, ]
    # #           
    # #       }
    # #       
    # #       
    # #       (currency.test.data - currency.data) * lot * sign(currency.indicators)
    # #       
    # #       list <- lapply(1:nrow(close.position.results), function(row_index) {
    # #         row <- close.position.results[row_index, ]
    # #         
    # #         for (x in row) {
    # #           if (x == TRUE) 
    # #         }        
    # #       })
    #     }    
    #     currency.close.position(currency.indicators, currency.data, currency.test.data, stop.loss.percent, take.profit.percent)      
    
    lapply(1:nrow(currency.indicators), function(row_index){
      currency.indicator.value <- currency.indicators[row_index]
      previous.currency.value <- currency.data[row_index] 
      for (test.value in currency.test.data[row_index, ]) {        
        
      }
    })
    
    close.position.results <- sapply(seq_along(currency.test.data), function(col_index) {
      currency.test.data.inreval <- currency.test.data[, col_index]
      
      currency.test.data.inreval/currency.data > take.profit.percent
      
      
      (currency.test.data.inreval - currency.data) * sign(currency.indicators)
      
      close.positions(currency.indicators, currency,data, currency.test.data.column, stop.loss.percent, take.profit.percent)
    })
  })
}

open.close.positions.indicators <- data.frame(eurjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1), usdjpy = c(0,NA,1,1,1,-1,-1,-1,-1,-1))
open.close.positions.data <- data.frame(eurjpy = c(1,3,6,10,15,21,28,36,45,55), usdjpy = c(1,3,6,10,15,21,28,36,45,55))
open.close.positions.test.data <- list(eurjpy = data.frame('2' = c(6,10,15,21,28,36,45,55,NA,NA), '5' = c(21,28,36,45,55,NA,NA,NA,NA,NA), check.names=FALSE), usdjpy=data.frame('2' = c(6,10,15,21,28,36,45,55,NA,NA), '5' = c(21,28,36,45,55,NA,NA,NA,NA,NA), check.names=FALSE))
open.close.positions.result <- open.close.positions(open.close.positions.indicators, open.close.positions.data, open.close.positions.test.data)
open.close.positions.result
do.call(cbind.data.frame, test.indicators.result)
