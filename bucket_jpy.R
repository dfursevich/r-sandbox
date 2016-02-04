library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

# goal is to find currency which is changing more/less than others at the moment and test 
# this gipotesy for this pair.

eurusd_full <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv", header=FALSE)
usdjpy_full <- read.csv("input/DAT_MT_USDJPY_M1_201508.csv", header=FALSE)
eurjpy_full <- read.csv("input/DAT_MT_EURJPY_M1_201508.csv", header=FALSE)
cadjpy_full <- read.csv("input/DAT_MT_CADJPY_M1_201508.csv", header=FALSE)
nzdjpy_full <- read.csv("input/DAT_MT_NZDJPY_M1_201508.csv", header=FALSE)
chfjpy_full <- read.csv("input/DAT_MT_CHFJPY_M1_201508.csv", header=FALSE)
audjpy_full <- read.csv("input/DAT_MT_AUDJPY_M1_201508.csv", header=FALSE)
gbpjpy_full <- read.csv("input/DAT_MT_GBPJPY_M1_201508.csv", header=FALSE)
gbpchf_full <- read.csv("input/DAT_MT_GBPCHF_M1_201508.csv", header=FALSE)

start_row = 0

eurjpy <- eurjpy_full[, c(1,2,6)]
usdjpy <- usdjpy_full[, c(1,2,6)]
cadjpy <- cadjpy_full[, c(1,2,6)]
nzdjpy <- nzdjpy_full[, c(1,2,6)]
chfjpy <- chfjpy_full[, c(1,2,6)]
audjpy <- audjpy_full[, c(1,2,6)]
gbpjpy <- gbpjpy_full[, c(1,2,6)]
gbpchf <- gbpchf_full[, c(1,2,6)]

# eurjpy <- eurjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# usdjpy <- usdjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# cadjpy <- cadjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# nzdjpy <- nzdjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# chfjpy <- chfjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# audjpy <- audjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# gbpjpy <- gbpjpy_full[start_row:(start_row + 1440), c(1,2,6)]

names(eurjpy) <- c("date", "time", "eurjpy")
names(usdjpy) <- c("date", "time", "usdjpy")
names(cadjpy) <- c("date", "time", "cadjpy")
names(nzdjpy) <- c("date", "time", "nzdjpy")
names(chfjpy) <- c("date", "time", "chfjpy")
names(audjpy) <- c("date", "time", "audjpy")
names(gbpjpy) <- c("date", "time", "gbpjpy")
names(gbpchf) <- c("date", "time", "gbpchf")

# eurjpy$date <- strptime(paste(eurjpy$date, eurjpy$time), "%Y.%m.%d %H:%M")
# usdjpy$date <- strptime(paste(usdjpy$date, usdjpy$time), "%Y.%m.%d %H:%M")
# eurjpy$time <- NULL 
# usdjpy$time <- NULL

data <- eurjpy
data <- merge(data, usdjpy, by=c("date","time"))
data <- merge(data, cadjpy, by=c("date","time"))
data <- merge(data, nzdjpy, by=c("date","time"))
data <- merge(data, chfjpy, by=c("date","time"))
data <- merge(data, audjpy, by=c("date","time"))
data <- merge(data, gbpjpy, by=c("date","time"))
data <- merge(data, gbpchf, by=c("date","time"))
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 

offset <- 10000

data$eurjpy_delta <- append(diff(data$eurjpy, offset), rep(NA, offset), after = 0) 
data$usdjpy_delta <- append(diff(data$usdjpy, offset), rep(NA, offset), after = 0) 
data$cadjpy_delta <- append(diff(data$cadjpy, offset), rep(NA, offset), after = 0) 
data$nzdjpy_delta <- append(diff(data$nzdjpy, offset), rep(NA, offset), after = 0) 
data$chfjpy_delta <- append(diff(data$chfjpy, offset), rep(NA, offset), after = 0) 
data$audjpy_delta <- append(diff(data$audjpy, offset), rep(NA, offset), after = 0) 
data$gbpjpy_delta <- append(diff(data$gbpjpy, offset), rep(NA, offset), after = 0) 

data$eurjpy_delta_wma <- WMA((data$eurjpy_delta), offset)
data$usdjpy_delta_wma <- WMA((data$usdjpy_delta), offset)
data$cadjpy_delta_wma <- WMA((data$cadjpy_delta), offset)
data$nzdjpy_delta_wma <- WMA((data$nzdjpy_delta), offset)
data$chfjpy_delta_wma <- WMA((data$chfjpy_delta), offset)
data$audjpy_delta_wma <- WMA((data$audjpy_delta), offset)
data$gbpjpy_delta_wma <- WMA((data$gbpjpy_delta), offset)

names <- c("eur", "usd", "cad", "nzd", "chf", "aud", "gbp")

f <- function(..., func, names) {    
  apply(cbind(...), 1, function(x) {
    coll <- which(x == func(x))
    ifelse(length(coll) == 0, NA, names[coll])                      
  })
}

data$min_cur = f(data$eurjpy_delta_wma, data$usdjpy_delta_wma, data$cadjpy_delta_wma, data$nzdjpy_delta_wma, data$chfjpy_delta_wma, data$audjpy_delta_wma, data$gbpjpy_delta_wma, func = min, names = names)
data$max_cur = f(data$eurjpy_delta_wma, data$usdjpy_delta_wma, data$cadjpy_delta_wma, data$nzdjpy_delta_wma, data$chfjpy_delta_wma, data$audjpy_delta_wma, data$gbpjpy_delta_wma, func = max, names = names)


test_data <- head(data,10)

timediff <- function(..., lag_mins) {
  df <- cbind(...)
  apply(df, 1, function(x) {
    class(x[1])
#     lag_date <- x[1] + (60 * lag_mins)
#     lag_x <- df[data[1] == lag_date,]
#     lag_diff <- x[2] - lag_x[2]
#     lag_diff
  })
}

timediff(test_data$date, test_data$gbpchf, lag_mins = 1)



intervals <- c(1024) 

for(int in intervals) {
  data[paste0("m", int)] = numeric(nrow(data))
  
  data2 <- lapply(1:nrow(data), function(i) {
    row = data[i, ]      
    
    dataInt = data[ifelse(i > int, i - int, 0) : (i - 1), ]  
    rowInt = dataInt[difftime(row$date, dataInt$date, units = "min") == int, ]    
    row[paste0("m", int)] = ifelse(nrow(rowInt) == 1, row$gbpchf - rowInt$gbpchf, NA)       
    
    row
  })  
  
  data2 <- do.call(rbind, data2)  
}

data_gbpchf <- subset(data2, min_cur == 'gbp' & max_cur == 'chf', select=c("date", "gbpjpy_delta_wma", "chfjpy_delta", "gbpchf", "m1024"))



aggregate(eurjpy ~ min_cur + max_cur, data = data, FUN = length)

g1 <- (ggplot(data) 
       + geom_line(aes(date, eurjpy_delta), colour = "red")         
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

g2 <- (ggplot(data)        
       + geom_line(aes(date, eurjpy_delta_wma), colour = "green") 
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))