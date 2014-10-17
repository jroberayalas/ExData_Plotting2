# Read data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Transform year variable to factor
NEI <- transform(NEI, year = factor(year))

# Find emissions from motor vehicle sources
vehicle <- SCC$SCC[grep("[Vv]ehicle", SCC$EI.Sector)]

# Use dplyr library to filter the rows that belong to emissions from motor vehicle sources 
# in Baltimore City, group by year, and summarise the sum of Emissions
library(dplyr)
NEI <- tbl_df(NEI)
sums.summary <- NEI %>%
    filter(SCC %in% vehicle, fips == "24510") %>%
    group_by(year) %>%
    summarize(sums = sum(Emissions))

# Plotting
png(file = "ExData_Plotting2/plot5.png", bg = "transparent")
with(sums.summary, plot(year, sums, 
                        xlab = "Year",
                        ylab = expression("Total emissions from PM"[2.5]),
                        main = "Total emissions from motor vehicle sources in Baltimore City"))
dev.off()