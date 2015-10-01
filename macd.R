data <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv")
names(data) <- c("date", "time", "open", "low", "high", "close", "xz")
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 
data$xz <- NULL

data <- tail(data, 100)
macd <- MACD(data$close, 12, 26, 9, maType="EMA", percent=FALSE)

par(mfrow = c(2, 1))

plot(EMA(data$close, 9), type="l")
points(data$close, col = "red", type="l")


plot(macd[,2], col = "blue", type="l", axes=FALSE)
points(macd[,1], col = "red", type="l", axes=FALSE)
axis(2, axTicks(2), format(axTicks(2), scientific = F))


macd2 <- MACD(data$close, 12, 26, 9, maType="EMA", percent=TRUE)
plot(macd2[,2], col = "blue", type="l")
points(macd2[,1], col = "red", type="l")

data1 <- tail(ttrc,100)
macd1  <- MACD(data1$Close, 12, 26, 9, maType="EMA" )
# plot(data1$Close, type="l")
plot(macd1[,2], col = "blue", type="l")
points(macd1[,1], col = "red", type="l")

macdData <- as.data.frame(macd)
macdData$id<-seq.int(nrow(macdData))

qplot(1:nrow(macdData), macd, data=macdData, geom = c("point", "path"))

macdDataLong = melt(macdData, id=c("id"))


ggplot(macdDataLong,  aes(x=id, y=value, colour=variable)) + geom_line()
  




# 
# macd