# Read data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Transform year variable to factor
NEI <- transform(NEI, year = factor(year))

# Use dplyr library to group by year and summarise the sum of Emissions
library(dplyr)
NEI <- tbl_df(NEI)
sums.summary <- NEI %>%
    group_by(year) %>%
    summarize(sums = sum(Emissions))

# Plotting
png(file = "ExData_Plotting2/plot1.png", bg = "transparent")
with(sums.summary, plot(year, sums, 
                        xlab = "Year",
                        ylab = expression("Total emissions from PM"[2.5]),
                        main = "Total emissions in the USA"))
dev.off()