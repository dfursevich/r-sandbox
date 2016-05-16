library(TTR)
source("./functions/merge.files.R")
source("./functions/generate.test.data.R")
source("./functions/open.close.positions.R")

data <- merge.files("./input/", "DAT_MT_(EURJPY).+201508\\.csv")

macd.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    macd <- MACD(cur.pair, 12, 26, 9)
    macd[,1]
  }))
test.intervals <- seq(2, 50, 2)
test.data <- generate.test.data(data, test.intervals, flat = FALSE)

signal.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    macd <- MACD(cur.pair, 12, 26, 9)
    macd[,1] - macd[,2]
  }))
test.macd.data <- generate.test.data(signal.data, test.intervals, flat = FALSE)

eurjpy.test.results <- do.call(cbind.data.frame, open.close.positions(macd.data['eurjpy'], data, test.data, test.macd.data, 0.06, 0.12))

sapply(eurjpy.test.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})
