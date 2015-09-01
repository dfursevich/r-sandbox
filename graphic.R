data <- read.csv("input/EURUSD_hour.csv", 
                 colClasses =c(rep("character", 3), rep("numeric", 4)), 
                 col.names = c("cur", "date", "time", "open", "low", "high", "close"))
data$date <- as.Date(data$date, format="%Y%m%d")

data <- head(data, 200)
output <- data.frame()


for(i in 1:nrow(data)) {
  
}

