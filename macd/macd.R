source("./functions/merge.files.R")

data <- merge.files("./input/", "DAT_MT_([^_]+).+201508\\.csv")
