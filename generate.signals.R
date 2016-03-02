generate.signals <- function(data, interval = NULL) {
  macd <- as.data.frame(MACD(data$eurjpy, 12, 26, 9, maType="EMA", percent=FALSE)) 
  
  signals <- data.frame(signal = macd$macd, currency="eurjpy")
  
  signals$action = ifelse(signals$signal >= 0, "buy", "sell")
  
  signals
}