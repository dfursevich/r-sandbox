data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

draw.currency.macd.plot(data[1:200,], 'eurjpy', TRUE)

test.intervals <- seq(3, 30, 3)

test.data <- generate.test.data(data, test.intervals)

signals <- generate.signals(data)

test.results <- test.signals(data, signals, test.intervals, test.data, 1)

sapply(test.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})
