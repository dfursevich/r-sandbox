test.function <- function(func, ...) {
  grid <- expand.grid(list(...))
  result = c()
  for (row_index in 1:nrow(grid)) {
    row <- grid[row_index, ]
    result <- append(result, do.call(func, as.list(row)))
  }
  grid$result <- result
  grid
}

test.function.result <- test.function(function(a, b) {a+b}, a = 1:2, b = 2:3)
test.function.result
setequal(test.function.result, data.frame(a = c(1,2,1,2), b = c(2,2,3,3), result=c(3,4,4,5)))