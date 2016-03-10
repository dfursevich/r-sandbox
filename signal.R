data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")

test.data <- generate.test.data(data, c(2))

signals <- generate.signals(data)

test.signals <- test.signals(data, test.data, signals)




