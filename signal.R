data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

signals <- generate.signals(data)

test.intervals <- c(5)

test.data < generate.test.data(data, test.intervals)


