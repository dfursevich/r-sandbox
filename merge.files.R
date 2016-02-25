merge.files <- function(input.dir, file.pattern) {
  files <- list.files(input.dir, pattern = file.pattern)
  
  files.data <- lapply(files, function(file) {  
    curr.name <- unlist(regmatches(file, regexec(file.pattern, file)))[2]
    file.data = read.csv(paste(input.dir, file, sep = ""), header=FALSE)   
    file.data <- file.data[, c(1,2,6)]
    names(file.data) <- c("date", "time", tolower(curr.name))  
    file.data
  })
  
  data <- Reduce(function(x, y) merge(x, y, by=c("date", "time")), files.data, accumulate=F)  
  
  data$date <- strptime(paste(data$date, data$time), "%Y.%m.%d %H:%M")      
  data$time <- NULL
  
  data
}