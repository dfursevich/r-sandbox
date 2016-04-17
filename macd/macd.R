library(TTR)
source("./functions/merge.files.R")
source("./functions/generate.test.data.R")
source("./functions/test.indicator.R")

data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

macd.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    MACD(cur.pair, 12, 26, 9)[,1]
  }))

test.intervals <- seq(5, 50, 5)
test.data <- generate.test.data(data, test.intervals)

eurjpy.test.results <- do.call(cbind.data.frame, test.indicators(macd.data['eurjpy'], data, test.data, test.intervals))

sapply(eurjpy.test.results, function(interval.results) {
  sum(interval.results, na.rm = TRUE)
})

percentile <- ceiling((ecdf(macd.data$eurjpy)(macd.data$eurjpy))*10)/10

# total income/loss
aggregate(. ~ percentile, data = cbind(percentile, eurjpy.test.results), FUN = sum)

# total success/failure deals income/loss
aggregate(. ~ percentile, data = cbind(percentile, eurjpy.test.results), FUN = function(x) {sum(x[!is.na(x) & x < 0])})

# total percent of succesful deals
aggregate(. ~ percentile, data = cbind(percentile, eurjpy.test.results), FUN = function(x) {
  x <- x[!is.na(x) & x != 0]
  round(length(x[x > 0])/length(x), 2) * 100
})

analyse.data <- cbind(percentile, macd.data, eurjpy.test.results['eurjpy.30'])
analyse.data <- analyse.data[analyse.data['eurjpy.30'] > 0, ]
# percentile <- ceiling((ecdf(analyse.data$eurjpy)(analyse.data$eurjpy))*10)/10
aggregate(. ~ percentile, data = cbind(analyse.data), FUN = function(x){round(mean(x),digits=4)})

analyse.data <- cbind(percentile, macd.data, eurjpy.test.results['eurjpy.30'])
analyse.data <- analyse.data[analyse.data['eurjpy.30'] < 0, ]
# percentile <- ceiling((ecdf(analyse.data$eurjpy)(analyse.data$eurjpy))*10)/10
aggregate(. ~ percentile, data = cbind(analyse.data), FUN = function(x){round(mean(x),digits=4)})





