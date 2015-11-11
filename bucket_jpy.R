library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

eurusd_full <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv", header=FALSE)
eurjpy_full <- read.csv("input/DAT_MT_EURJPY_M1_201508.csv", header=FALSE)
cadjpy_full <- read.csv("input/DAT_MT_CADJPY_M1_201508.csv", header=FALSE)
nzdjpy_full <- read.csv("input/DAT_MT_NZDJPY_M1_201508.csv", header=FALSE)
chfjpy_full <- read.csv("input/DAT_MT_CHFJPY_M1_201508.csv", header=FALSE)
audjpy_full <- read.csv("input/DAT_MT_AUDJPY_M1_201508.csv", header=FALSE)
gbpjpy_full <- read.csv("input/DAT_MT_GBPJPY_M1_201508.csv", header=FALSE)

start_row = 0

eurjpy <- eurjpy_full[start_row:(start_row + 1440), c(1,2,6)]
usdjpy <- usdjpy_full[start_row:(start_row + 1440), c(1,2,6)]
cadjpy <- cadjpy_full[start_row:(start_row + 1440), c(1,2,6)]
nzdjpy <- nzdjpy_full[start_row:(start_row + 1440), c(1,2,6)]
chfjpy <- chfjpy_full[start_row:(start_row + 1440), c(1,2,6)]
audjpy <- audjpy_full[start_row:(start_row + 1440), c(1,2,6)]
gbpjpy <- gbpjpy_full[start_row:(start_row + 1440), c(1,2,6)]

names(eurjpy) <- c("date", "time", "eurjpy")
names(usdjpy) <- c("date", "time", "usdjpy")
names(cadjpy) <- c("date", "time", "cadjpy")
names(nzdjpy) <- c("date", "time", "nzdjpy")
names(chfjpy) <- c("date", "time", "chfjpy")
names(audjpy) <- c("date", "time", "audjpy")
names(gbpjpy) <- c("date", "time", "gbpjpy")

data <- eurjpy
data <- merge(data, usdjpy, by=c("date","time"))
data <- merge(data, cadjpy, by=c("date","time"))
data <- merge(data, nzdjpy, by=c("date","time"))
data <- merge(data, chfjpy, by=c("date","time"))
data <- merge(data, audjpy, by=c("date","time"))
data <- merge(data, gbpjpy, by=c("date","time"))
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 

data$total <- data$eurjpy + data$usdjpy + data$cadjpy + data$nzdjpy + data$chfjpy + data$chfjpy + data$gbpjpy

g1 <- (ggplot(data) 
       + geom_line(aes(date, total), colour = "red")         
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