library(ggplot2)
library(grid)
library(gridExtra)
library(scales)
library(TTR)

draw.currency.macd.plot <- function(currency, macd = TRUE) {    
  macd.data <- as.data.frame(MACD(currency, 12, 26, 9))
  plot.data <- data.frame(
    currency = currency,
    slow = EMA(currency, 26),
    fast = EMA(currency, 12),
    macd = macd.data$macd,
    signal = macd.data$signal,
    idx = 1:length(currency)
  )
  
  g1 <- (ggplot(plot.data) 
         + geom_line(aes(idx, slow), colour = "green") 
         + geom_line(aes(idx, fast), colour = "blue") 
         + geom_line(aes(idx, currency))           
         + theme(axis.text.x=element_blank(),
                 axis.title.x=element_blank(),
                 plot.title=element_blank(),
                 axis.ticks.x=element_blank()))     
  if (macd) {
    macd <- as.data.frame(MACD(plot.data$currency, 12, 26, 9, maType="EMA", percent=FALSE))  
    plot.data <- cbind(plot.data, macd)
    
    g2 <- (ggplot(plot.data)
           + geom_line(aes(idx, macd), colour = "green") 
           + geom_line(aes(idx, signal), colour = "black") 
           + geom_bar(aes(idx, macd-signal), stat = "identity", colour = "blue", fill="white")            
           + theme(plot.margin = unit(c(-1,0,0,0), "lines")))
    
    grid.draw(rbind(ggplotGrob(g1), ggplotGrob(g2), size="last"))  
  } else {
    grid.draw(ggplotGrob(g1))    
  }
}

draw.currency.macd.plot.data <- data.frame(eurjpy = cumsum(1:200))
draw.currency.macd.plot(draw.currency.macd.plot.data$eurjpy)