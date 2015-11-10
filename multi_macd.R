library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

eurusd_full <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv", header=FALSE)
eurjpy_full <- read.csv("input/DAT_MT_EURJPY_M1_201508.csv", header=FALSE)
usdjpy_full <- read.csv("input/DAT_MT_USDJPY_M1_201508.csv", header=FALSE)

start_row = 0

eurusd <- eurusd_full[ , c(1,2,6)]
eurjpy <- eurjpy_full[ , c(1,2,6)]
usdjpy <- usdjpy_full[ , c(1,2,6)]
# eurusd <- eurusd_full[start_row:(start_row + 1440), c(1,2,6)]
# eurjpy <- eurjpy_full[start_row:(start_row + 1440), c(1,2,6)]
# usdjpy <- usdjpy_full[start_row:(start_row + 1440), c(1,2,6)]

names(eurusd) <- c("date", "time", "eurusd")
names(eurjpy) <- c("date", "time", "eurjpy")
names(usdjpy) <- c("date", "time", "usdjpy")

data <- eurusd
data <- merge(data, eurjpy, by=c("date","time"))
data <- merge(data, usdjpy, by=c("date","time"))
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 

data$eurusdjpy <- data$eurjpy - data$usdjpy


eurusdjpymax = max(data$eurusdjpy)
eurusdmax = max(data$eurusd)
eurjpymax = max(data$eurjpy)
usdjpymax = max(data$usdjpy)

data$eurusd_norm <- data$eurusd/eurusdmax
data$eurjpy_norm <- data$eurjpy/eurjpymax
data$usdjpy_norm <- data$usdjpy/usdjpymax
data$eurusdjpy_norm <- data$eurusdjpy/eurusdjpymax


g1 <- (ggplot(data) 
       + geom_line(aes(date, eurusdjpy), colour = "red")        
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 


g2 <- (ggplot(data)        
       + geom_line(aes(date, eurusd), colour = "green") 
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))


g3 <- (ggplot(data)        
       + geom_line(aes(date, eurusdjpy_norm - eurusd_norm))  
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

g3


summary(data$eurusd)

