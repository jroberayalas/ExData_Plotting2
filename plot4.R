# Read data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Transform year variable to factor
NEI <- transform(NEI, year = factor(year))

# Find emissions from coal combustion-related sources
coal <- SCC$SCC[grep("[Cc]oal", SCC$EI.Sector)]

# Use dplyr library to filter the rows that belong to emissions from coal combustion-related sources, 
# group by year, and summarise the sum of Emissions
library(dplyr)
NEI <- tbl_df(NEI)
sums.summary <- NEI %>%
    filter(SCC %in% coal) %>%
    group_by(year) %>%
    summarize(sums = sum(Emissions))

# Plotting
png(file = "ExData_Plotting2/plot4.png", bg = "transparent")
with(sums.summary, plot(year, sums, 
                        xlab = "Year",
                        ylab = expression("Total emissions from PM"[2.5]),
                        main = "Total emissions from coal combustion-related sources in the USA"))
dev.off()