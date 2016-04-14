source("./functions/merge.files.R")

data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

macd.data <- as.data.frame(sapply(data, function(cur.pair) {
  MACD(cur.pair, 12, 26, 9)[,1]
}))

test.intervals <- seq(5, 50, 5)
test.data <- generate.test.data(data, test.intervals)

eurjpy.test.results <- test.indicator(macd.data$eurjpy, test.intervals, test.data)
test.results <- test.indicator(macd.data, test.intervals[1], test.data)