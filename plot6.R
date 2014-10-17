# Read data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Transform year variable to factor
NEI <- transform(NEI, year = factor(year))

# Find emissions from motor vehicle sources
vehicle <- SCC$SCC[grep("[Vv]ehicle", SCC$EI.Sector)]

# Use dplyr library to filter the rows that belong to emissions from motor vehicle sources 
# in Baltimore City and Los Angeles County, group by year, and summarise the sum of Emissions
library(dplyr)
NEI <- tbl_df(NEI)
sums.summary <- NEI %>%
    filter(SCC %in% vehicle, fips == "24510" | fips == "06037") %>%
    group_by(year, fips) %>%
    summarize(sums = sum(Emissions))

# Plotting
library(ggplot2)
png(file = "ExData_Plotting2/plot6.png", bg = "transparent", width = 693, height = 501)
theme_set(theme_gray(base_size = 18))
qplot(data = sums.summary, x = year, y = log10(sums), col = fips) + 
    geom_point(size = 3) +
    geom_line(aes(group = fips)) +
    xlab("Year") +
    ylab(expression("Log 10 of total emissions from PM"[2.5])) +
    ggtitle("Total emissions from motor vehicle sources") + 
    scale_fill_discrete(name = "City", 
                        breaks = c("06037", "24510"), 
                        labels = c("Los Angeles", "Baltimore"))
dev.off()