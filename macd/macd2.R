# install.packages("scatterplot3d", repos="http://R-Forge.R-project.org")
library(TTR)
library(scatterplot3d)
source("./functions/merge.files.R")
source("./functions/generate.test.data.R")
source("./functions/open.close.positions.R")
source("./functions/test.function.R")

data <- merge.files("./input/", "DAT_MT_(EURJPY).+201508\\.csv")

macd.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    macd <- MACD(cur.pair, 12, 26, 9)
    ifelse(abs(macd[,1]) > 0.018, (-1) * macd[,1], NA)
  }))
test.intervals <- seq(2, 50, 2)
test.data <- generate.test.data(data, test.intervals, flat = FALSE)

signal.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    macd <- MACD(cur.pair, 12, 26, 9)
    (1) * macd[,2]
  }))
test.macd.data <- generate.test.data(signal.data, test.intervals, flat = FALSE)

func <- function(stop.loss, take.profit) {
  eurjpy.test.results <- do.call(cbind.data.frame, open.close.positions(macd.data['eurjpy'], data, test.data, test.macd.data, stop.loss, take.profit))
  
  sapply(eurjpy.test.results, function(interval.results) {
    sum(interval.results, na.rm = TRUE)
  })
}

# result.grid <- test.function(func, stop.loss = seq(0, 0.15, 0.05), take.profit = seq(0, 0.15, 0.05))
result.grid <- test.function(func, stop.loss = c(20), take.profit = c(20))

scatterplot3d(result.grid$stop.loss,result.grid$take.profit, result.grid$result)

# test.function(func, stop.loss = c(0.03), take.profit = c(0.01))





