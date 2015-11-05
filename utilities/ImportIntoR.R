library(readstata13)

uci <- read.dta13("UCIMerge_8Oct2015233253.dta", generate.factors = T, encoding = "UTF-8")

# Create an array of variable labels
# labels <- attr(uci, "var.label")

# Create labels for RStudio
attr(uci, "variable.labels") <- attr(uci, "var.label")

# Save a codebook
uci.codebook <- data.frame(names = attr(uci, "names"), labels = attr(uci, "var.label"))
