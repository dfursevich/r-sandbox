data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

draw.currency.macd.plot(data, 'gbpcad', FALSE)

test.intervals <- seq(3, 30, 3)

test.data <- generate.test.data(data, test.intervals)

signals <- generate.signals(data)

signals.results <- test.signals(data, signals, test.intervals, test.data, 1000)

sapply(test.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})

aggregate(. ~ currency, data = cbind(signals, signals.results), FUN = sum)
