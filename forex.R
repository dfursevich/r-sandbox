data <- head(read.csv("EURUSD_hour.csv", colClasses ="character"))
output <- data.frame(sample = NA, duplicate = NA, matches = NA)
dfrow <- 1
ascending = TRUE
ascending
for(i in 1:nrow(data)) {
  i
  currentRow <- data[i, ]
  currentRow
#   for(j in (i+1):nrow(data)) {
#     nextRow <- data[j,]
#     delta = as.numeric(nextRow["X.OPEN."]) - as.numeric(currentRow["X.OPEN."])
#     delta
    
#     ifdelta <- delta > 0
#     if (xor(ascending, ifdelta)) {
#       ascending = !ascending
#       delta
#       break
#     }    
#   }
}



# if (delta > 0 & descending) {
#   output[dfrow, ] <- [currentRow["X.DATE."], currentRow["X.DATE."], j, delta]
#   dfrow <- dfrow + 1
#   
#   break
# } 