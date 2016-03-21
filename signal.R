data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

# data <- head(data, 1000)

test.intervals <- c(2,5)

test.data <- generate.test.data(data, test.intervals)

signals <- generate.signals(data)

test.results <- test.signals(data, signals, test.intervals, test.data, 10000)

lapply(test.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})
