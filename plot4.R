setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- grep("*Coal*", SCC$SCC.Level.Three)
combustion <- grep("*Combustion*", SCC$SCC.Level.One)
idx <- SCC[intersect(coal, combustion), 1]
coal.comb.related <- NEI[NEI$SCC %in% idx, ]
total.by.coal.comb <- aggregate(coal.comb.related$Emissions, by=list(Category=coal.comb.related$year), FUN=sum)

png(file="/Users/yahsintsai/Downloads/plot4.png")
plot(total.by.coal.comb, xlab = 'Year', ylab = 'Total PM2.5 Emission from Coal Combustion-Related Sources')
dev.off()
