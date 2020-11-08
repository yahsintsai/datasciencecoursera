setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

x <- subset(NEI, fips=='24510')
total <- aggregate(x$Emissions, by=list(Category=x$year), FUN=sum)

png(file="/Users/yahsintsai/Downloads/plot2.png")
plot(total, xlab = 'Year', ylab = 'Total PM2.5 Emission in Baltimore City, Maryland')
dev.off()
