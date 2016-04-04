library(TTR)

generate.signals <- function(data, interval = NULL) {
  macd <- as.data.frame(MACD(data$eurjpy, 12, 26, 9, maType="EMA", percent=FALSE)) 
  
  signals <- data.frame(signal = macd$macd, currency="eurjpy")
#   signals <- data.frame(signal = rep(1, length(data$eurjpy)), currency="eurjpy")
  
  signals
}

generate.signals.data <- data.frame(eurjpy = cumsum(1:100))
generate.signals(generate.signals.data)