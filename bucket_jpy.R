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

start_row = 0

eurjpy <- eurjpy_full[, c(1,2,6)]
usdjpy <- usdjpy_full[, c(1,2,6)]
cadjpy <- cadjpy_full[, c(1,2,6)]
nzdjpy <- nzdjpy_full[, c(1,2,6)]
chfjpy <- chfjpy_full[, c(1,2,6)]
audjpy <- audjpy_full[, c(1,2,6)]
gbpjpy <- gbpjpy_full[, c(1,2,6)]

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
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 

delta <- 10000

data$eurjpy_delta <- data$eurjpy - data$eurjpy[1:(length(data$eurjpy))]
data$usdjpy_delta <- data$usdjpy[length(data$usdjpy)] - data$usdjpy[1:(length(data$usdjpy))]
data$cadjpy_delta <- data$cadjpy[length(data$cadjpy)] - data$cadjpy[1:(length(data$cadjpy))]
data$nzdjpy_delta <- data$nzdjpy[length(data$nzdjpy)] - data$nzdjpy[1:(length(data$nzdjpy))]
data$chfjpy_delta <- data$chfjpy[length(data$chfjpy)] - data$chfjpy[1:(length(data$chfjpy))]
data$audjpy_delta <- data$audjpy[length(data$audjpy)] - data$audjpy[1:(length(data$audjpy))]
data$gbpjpy_delta <- data$gbpjpy[length(data$gbpjpy)] - data$gbpjpy[1:(length(data$gbpjpy))]

data$eurjpy_delta_wma <- WMA((data$eurjpy_delta), 10000)
data$usdjpy_delta_wma <- WMA((data$usdjpy_delta), 10000)
data$cadjpy_delta_wma <- WMA((data$cadjpy_delta), 10000)
data$nzdjpy_delta_wma <- WMA((data$nzdjpy_delta), 10000)
data$chfjpy_delta_wma <- WMA((data$chfjpy_delta), 10000)
data$audjpy_delta_wma <- WMA((data$audjpy_delta), 10000)
data$gbpjpy_delta_wma <- WMA((data$gbpjpy_delta), 10000)





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