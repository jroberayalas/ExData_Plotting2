# Read data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Transform type and year variables to factor
NEI <- transform(NEI, type = factor(type), year = factor(year))

# Use dplyr library to filter the rows that belong to the Baltimore City, 
# group by year and type, and summarise the sum of Emissions
library(dplyr)
NEI <- tbl_df(NEI)
sums.summary <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarize(sums = sum(Emissions))

# Plotting using ggplot2
library(ggplot2)
png(file = "ExData_Plotting2/plot3.png", bg = "transparent", width = 693, height = 501)
theme_set(theme_gray(base_size = 18))
qplot(data = sums.summary, x = year, y = log10(sums), col = type) + 
    geom_point(size = 3) +
    geom_line(aes(group = type)) +
    xlab("Year") +
    ylab(expression("Log 10 of total emissions from PM"[2.5])) +
    ggtitle("Total emissions by type in the Baltimore City, Maryland")
dev.off()