merge.files <- function(input.dir, file.pattern) {
  files <- list.files(input.dir, pattern = file.pattern)
  
  files.data <- lapply(files, function(file) {  
    curr.name <- unlist(regmatches(file, regexec(file.pattern, file)))[2]
    file.data = read.csv(paste(input.dir, file, sep = ""), header=FALSE, colClasses = c("character", "numeric", "numeric", "numeric", "numeric", "numeric"))   
    file.data <- file.data[, c(1,5)]
    names(file.data) <- c("date", tolower(curr.name))  
    file.data
  })
  
  data <- Reduce(function(x, y) merge(x, y, by=c("date"), sort=FALSE), files.data, accumulate=F)  
  data
}

cor.shift <- function(x, y, shift) {
  unlist(lapply(1:shift, function(i) {
    cor(x[i:length(x)], y[1:(length(y) - i + 1)])
  }))
}

data <- merge.files("./", "(.*)\\.csv")

cor(data[, 2: ncol(data)])

cor.shift(data[, 3], data[, 4], 40)