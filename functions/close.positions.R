close.positions <- function(data) {
  list <- lapply(1:nrow(data), function(row_index) {
    row <- data[row_index, ]
    lapply()
    
  })
}

close.positions.data <- data.frame(eurjpy.5 = sample.int(100, 100), eurjpy.10 = sample.int(100, 100), eurjpy.15 = sample.int(100, 100), eurjpy.20 = sample.int(100, 100))
close.positions.results <- close.positions(close.positions.data)
close.positions.results

sapply(close.positions.data[1,], function(x) {
  if (x )
})
