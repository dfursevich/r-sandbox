require(gdata)

data <- read.csv("input/EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

# data <- head(data, 200)

data$delta <- data$close - data$open
data$maxDelta <- data$high - data$low
data$openDelta <- ifelse(data$delta >= 0, data$open - data$low, data$high - data$open)
data$closeDelta <- ifelse(data$delta >= 0, data$high - data$close, data$close - data$low)
#1-openDelta and closeDelta eash less then 25% of maxDelta, 
#2-openDelta less then 25% of maxDelta
#3-closeDelta less then 25% of maxDelta
#4-others
data$hourType <- ifelse(data$openDelta/data$maxDelta <= 0.25 & data$closeDelta/data$maxDelta <= 0.25, 1, 
              ifelse(data$openDelta/data$maxDelta <= 0.25, 2, 
              ifelse(data$closeDelta/data$maxDelta <= 0.25, 3, 4)))

data$hourType2 <- ifelse(data$openDelta == 0 & data$closeDelta == 0, 1, 
                         ifelse(data$openDelta == 0 | data$closeDelta == 0, 2, 3))
#                                ifelse(data$closeDelta/data$maxDelta <= 0.25, 3, 4)))

data

# hourType <- data$hourType[!is.na(data$hourType)]
# 
# # Generate all possible permutation with repetitions
# grid = expand.grid(rep(list(1:4), 3))
# permutations <- apply(grid, 1, function(row) {
#   paste(row, collapse="")
# })
# ########
# 
# hourTypeAggr <- numeric(length = length(permutations))
# names(hourTypeAggr) = permutations
# for(i in 1:(length(hourType) - 2)) {
#   permutation <- paste(hourType[i:(i+2)], collapse="")    
#   hourTypeAggr[permutation] = hourTypeAggr[permutation] + 1
# }
# 
# hourTypeAggr

data <- data[data$maxDelta >= 0.0010, ]

output <- aggregate(cur ~ format(date, "%Y") + hourType2, data, length)
names(output)[1]<-"year"
output <- xtabs(cur ~ hourType2 + year, data = output)
write.fwf(output, file = "output/hour_output.csv")