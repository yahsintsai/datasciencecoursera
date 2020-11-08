setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

png(file="/Users/yahsintsai/Downloads/plot1.png")
plot(total, xlab = 'Year', ylab = 'Total PM2.5 Emission form All Sources')
dev.off()
