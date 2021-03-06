source("./functions/merge.files.R")
source("./functions/draw.currency.macd.plot.R")
source("./functions/generate.test.data.R")
source("./functions/test.signals.R")

source("./signal/generate.signals.v2.R")

data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

draw.currency.macd.plot(data$eurjpy[1:200], TRUE)

test.intervals <- seq(5, 50, 5)

test.data <- generate.test.data(data, test.intervals)

signals <- generate.signals.v2(data)

signals.results <- test.signals(data, signals, test.intervals, test.data, 1000)

sapply(signals.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})

percentile <- round(ecdf(signals$signal)(signals$signal), digits=1)

aggregate(. ~ currency + percentile, data = cbind(signals, percentile, signals.results), FUN = sum)
# aggregate(. ~ currency, data = cbind(signals, percentile, signals.results), FUN = sum)
aggregate(. ~ currency + percentile, data = cbind(signals, percentile, signals.results), FUN = function(x) {round(length(x[sign(x) == -1]) / length(x[sign(x) == 1]), 2)})

aggregate(. ~ currency + percentile, data = cbind(signals, percentile, signals.results), FUN = mean)
