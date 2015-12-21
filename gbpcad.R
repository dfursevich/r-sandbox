aug_full <- read.csv("input/DAT_MT_GBPCAD_M1_201508.csv", header=FALSE)
sep_full <- read.csv("input/DAT_MT_GBPCAD_M1_201509.csv", header=FALSE)
aug <- aug_full[, c(1,2,6)]
sep <- sep_full[, c(1,2,6)]
names(aug) <- c("date", "time", "gbpcad")
names(sep) <- c("date", "time", "gbpcad")
aug$date <- strptime(paste(aug$date, aug$time), "%Y.%m.%d %H:%M")
sep$date <- strptime(paste(sep$date, sep$time), "%Y.%m.%d %H:%M")
aug$time <- NULL 
sep$time <- NULL

g1 <- (ggplot(aug) 
       + geom_line(aes(date, gbpcad), colour = "red")        
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 


g2 <- (ggplot(sep)        
       + geom_line(aes(date, gbpcad), colour = "green") 
       + scale_x_datetime(breaks = date_breaks("15 min"), labels = date_format("%H:%M"))
       + theme(axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               plot.title=element_blank(),
               axis.ticks.x=element_blank())) 

grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))

