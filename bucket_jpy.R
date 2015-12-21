library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

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


offset <-

eurjpy_delta <- data$eurjpy[length(data$eurjpy)] - data$eurjpy[1:(length(data$eurjpy) - 1)]
usdjpy_delta <- data$usdjpy[length(data$usdjpy)] - data$usdjpy[1:(length(data$usdjpy) - 1)]
cadjpy_delta <- data$cadjpy[length(data$cadjpy)] - data$cadjpy[1:(length(data$cadjpy) - 1)]
nzdjpy_delta <- data$nzdjpy[length(data$nzdjpy)] - data$nzdjpy[1:(length(data$nzdjpy) - 1)]
chfjpy_delta <- data$chfjpy[length(data$chfjpy)] - data$chfjpy[1:(length(data$chfjpy) - 1)]
audjpy_delta <- data$audjpy[length(data$audjpy)] - data$audjpy[1:(length(data$audjpy) - 1)]
gbpjpy_delta <- data$gbpjpy[length(data$gbpjpy)] - data$gbpjpy[1:(length(data$gbpjpy) - 1)]



tail(WMA((eurjpy_delta), length(eurjpy_delta)), 1)
tail(WMA((usdjpy_delta), length(usdjpy_delta)), 1)
tail(WMA((cadjpy_delta), length(cadjpy_delta)), 1)
tail(WMA((nzdjpy_delta), length(nzdjpy_delta)), 1)
tail(WMA((chfjpy_delta), length(chfjpy_delta)), 1)
tail(WMA((audjpy_delta), length(audjpy_delta)), 1)
tail(WMA((gbpjpy_delta), length(gbpjpy_delta)), 1)

data$total <- data$eurjpy + data$usdjpy + data$cadjpy + data$nzdjpy + data$chfjpy + data$chfjpy + data$gbpjpy

g1 <- (ggplot(data) 
       + geom_line(aes(date, eurjpy), colour = "red")         
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

g2 <- (ggplot(data)        
       + geom_line(aes(date, gbpjpy), colour = "green") 
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))