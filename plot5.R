setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor <- grep("*Motor*", SCC$SCC.Level.Four)
idx <- SCC[motor, 1]
motor.in.bal <- subset(NEI, SCC = idx, fips=='24510')
total.motor.in.bal <- aggregate(motor.in.bal$Emissions, by=list(Category=motor.in.bal$year), FUN=sum)

png(file="/Users/yahsintsai/Downloads/plot5.png")
plot(total.motor.in.bal, xlab = 'Year', ylab = 'Total PM2.5 Emission from Motor Vehicles in Baltimore')
dev.off()
