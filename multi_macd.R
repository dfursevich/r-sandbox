eurusd <- read.csv("input/DAT_MT_EURUSD_M1_201508.csv", nrows=100, header=FALSE)
eurjpy <- read.csv("input/DAT_MT_EURJPY_M1_201508.csv", nrows=100, header=FALSE)
usdjpy <- read.csv("input/DAT_MT_USDJPY_M1_201508.csv", nrows=100, header=FALSE)

eurusd <- eurusd[, c(1,2,6)]
eurjpy <- eurjpy[, c(1,2,6)]
usdjpy <- usdjpy[, c(1,2,6)]

names(eurusd) <- c("date", "time", "eurusd")
names(eurjpy) <- c("date", "time", "eurjpy")
names(usdjpy) <- c("date", "time", "usdjpy")

data <- eurusd
data <- merge(data, eurjpy, by=c("date","time"))
data <- merge(data, usdjpy, by=c("date","time"))
data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")
data$time <- NULL 

eurjpy_mean <- mean(data$eurjpy)
usdjpy_mean <- mean(data$usdjpy)
data$eurjpy_delta <- data$eurjpy - eurjpy_mean
data$usdjpy_delta <-data$usdjpy - usdjpy_mean

g1 <- (ggplot(data) 
       + geom_line(aes(date, eurjpy_delta), colour = "red")  
       + geom_line(aes(date, usdjpy_delta), colour = "blue") 
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

g2 <- (ggplot(data)        
       + geom_line(aes(date, usdjpy))  
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

g3 <- (ggplot(data)        
       + geom_line(aes(date, eurusd))  
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), ggplotGrob(g3), size="last"))

summary(data$eurusd)

