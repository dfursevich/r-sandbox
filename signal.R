data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

signals <- generate.signals(data)

testIntervals <- c(5, 10, 15, 20)


