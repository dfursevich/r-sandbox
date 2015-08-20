data <- read.csv("forex/EURUSD_hour.csv", colClasses ="character")
data[1:10,"X.OPEN."]
for(i in 1:nrow(data)) {
  sample <- data[i, ]
  for(j in (i+1):nrow(data)) 
    if(i+1 <= nrow(data)) {
      matches <- 0
      for(V in 1:ncol(data)) {
        if(data[j,V] == sample[,V]) {       
          matches <- matches + 1
        }
      }
      if(matches > 3) {
        duplicate <- data[j, ]
        pair <- cbind(rownames(sample), rownames(duplicate), matches)
        output[dfrow, ] <- pair
        dfrow <- dfrow + 1
      }
  }
}