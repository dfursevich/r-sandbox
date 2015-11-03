library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

data <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv")
names(data) <- c("date", "time", "open", "low", "high", "close", "xz")
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$date1 <- as.Date(data$date)
data$time <- NULL 
data$xz <- NULL

data <- tail(data, 200)
macd <- as.data.frame(MACD(data$close, 12, 26, 9, maType="EMA", percent=FALSE))

data <- cbind(data, macd)

g2 <- (ggplot(data)
  + geom_line(aes(date, macd), colour = "green") 
  + geom_line(aes(date, signal), colour = "black") 
  + geom_bar(aes(date, macd-signal), stat = "identity", colour = "blue", fill="white")   
  + scale_y_continuous(labels = comma)
  + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))  
  + theme(plot.margin = unit(c(-1,0,0,0), "lines")))

g1 <- (ggplot(data) 
  + geom_line(aes(date, close))  
  + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
  + theme(axis.text.x=element_blank(),
           axis.title.x=element_blank(),
           plot.title=element_blank(),
           axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))
