library(TTR)

generate.signals.v2 <- function(data, interval = NULL) {
  data.macd <- as.data.frame(sapply(data, function(cur.pair) {
    MACD(cur.pair, 12, 26, 9)[,1]
  }))
  
  signals.list <- lapply(1:nrow(data.macd), function(row_index) {
    macd <- data.macd[row_index, ]
#     signal.value <- ifelse(is.na(macd$eurjpy) || is.na(macd$usdjpy) || is.na(macd$eurusd), NA, 
#                            ifelse(macd$eurjpy > 0 && macd$usdjpy > 0 && macd$eurusd > 0 && (macd$eurjpy < macd$usdjpy), -1, NA))
#     signal.value <- ifelse(is.na(macd$eurjpy) || is.na(macd$usdjpy) || is.na(macd$eurusd), NA, 
#                            ifelse(macd$eurjpy > 0 && macd$usdjpy > 0 && macd$eurusd < 0 && (macd$eurjpy > macd$usdjpy), 1, NA))
#     signal.value <- ifelse(is.na(macd$eurjpy) || is.na(macd$usdjpy) || is.na(macd$eurusd), NA, 
#                            ifelse(macd$eurjpy > 0 && macd$usdjpy > 0 && macd$eurusd < 0 && (macd$eurjpy > macd$usdjpy), -1 * macd$eurusd, NA))
    
    signal.value <- macd$eurjpy
    
    list(signal = signal.value, currency = ifelse(is.na(signal.value), NA, 'eurjpy'))
  })
  
  signals <- do.call(rbind.data.frame, signals.list) 
  signals
  # data.macd
}

generate.signals.v2.data <- data.frame(eurjpy = sample.int(100, 100), usdjpy = sample.int(100, 100), 
                                    cadjpy = sample.int(100, 100), nzdjpy = sample.int(100, 100),
                                    chfjpy = sample.int(100, 100), audjpy = sample.int(100, 100),
                                    gbpjpy = sample.int(100, 100), eurusd = sample.int(100, 100))
generate.signals.v2.results <- generate.signals.v2(generate.signals.v2.data)
generate.signals.v2.results
