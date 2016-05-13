library(TTR)
source("./functions/merge.files.R")
source("./functions/generate.test.data.R")
source("./functions/open.close.positions.R")

data <- merge.files("./input/", "DAT_MT_(EURJPY).+201508\\.csv")
data <- head(data, 200)

macd.data <- as.data.frame(
  sapply(data, function(cur.pair) {
    macd <- MACD(cur.pair, 12, 26, 9)
    macd[,1] - macd[,2]
  }))

test.intervals <- seq(5, 50, 5)
test.data <- generate.test.data(data, test.intervals, flat = FALSE)

eurjpy.test.results <- do.call(cbind.data.frame, open.close.positions(macd.data['eurjpy'], data, test.data))