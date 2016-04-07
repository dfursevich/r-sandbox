library(TTR)

generate.signals <- function(data, interval = NULL) {
  macd.eur <- as.data.frame(MACD(data$eurjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.usd <- as.data.frame(MACD(data$usdjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.cad <- as.data.frame(MACD(data$cadjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.nzd <- as.data.frame(MACD(data$nzdjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.chf <- as.data.frame(MACD(data$chfjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.aud <- as.data.frame(MACD(data$audjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  macd.gbp <- as.data.frame(MACD(data$gbpjpy, 12, 26, 9, maType="EMA", percent=TRUE)) 
  
  cur.names <- c("eur", "usd", "cad", "nzd", "chf", "aud", "gbp")
  cur.pairs <- c("audcad", "audchf", "audjpy", "audnzd", "audusd", "cadchf", "cadjpy", "chfjpy",
                 "euraud", "eurcad", "eurchf", "eurgbp", "eurjpy", "eurnzd", "eurusd", "gbpaud",
                 "gbpcad", "gbpchf", "gbpjpy", "gbpnzd", "gbpusd", "nzdcad", "nzdchf", "nzdjpy",
                 "nzdusd", "usdcad", "usdchf", "usdjpy") #(n/k) = (n!)/(k!(n-k)!) (8/2)=28
  macds <- cbind(macd.eur$macd, macd.usd$macd, macd.cad$macd, macd.nzd$macd, macd.chf$macd, macd.aud$macd, macd.gbp$macd)
  
  signals.list <- lapply(1:nrow(macds), function(row_index) {
    macd <- macds[row_index, ]
    macd.min <- min(macd)
    macd.max <- max(macd)
    macd.min.idx <- which(macd == macd.min)
    macd.max.idx <- which(macd == macd.max)
    macd.min.name <- ifelse(length(macd.min.idx) == 0, NA, cur.names[macd.min.idx])
    macd.max.name <- ifelse(length(macd.max.idx) == 0, NA, cur.names[macd.max.idx])
    
    pair.1 <- paste(macd.max.name, macd.min.name, sep="")
    pair.2 <- paste(macd.min.name, macd.max.name, sep="")
#     
    if (pair.1 %in% cur.pairs) {
      return(list(signal = (macd.max - macd.min), currency = pair.1))      
    } else if (pair.2 %in% cur.pairs) {
      return(list(signal = (macd.min - macd.max), currency = pair.2))      
    } else {
      return(list(signal = NA, currency = NA))
    }   
  })
  
  signals <- do.call(rbind.data.frame, signals.list) 
#   names(signals) <- c("signal", "currency")
#   signals$signal <- as.numeric(signals$signal)
  signals
}

generate.signals.data <- data.frame(eurjpy = sample.int(100, 100), usdjpy = sample.int(100, 100), 
                                    cadjpy = sample.int(100, 100), nzdjpy = sample.int(100, 100),
                                    chfjpy = sample.int(100, 100), audjpy = sample.int(100, 100),
                                    gbpjpy = sample.int(100, 100))
generate.signals.results <- generate.signals(generate.signals.data)
generate.signals.results
