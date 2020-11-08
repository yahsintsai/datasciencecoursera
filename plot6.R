setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor <- grep("*Motor*", SCC$SCC.Level.Four)
idx <- SCC[motor, 1]
motor.in.bal <- subset(NEI, SCC = idx, fips=='24510')
total.motor.in.bal <- aggregate(motor.in.bal$Emissions, by=list(Category=motor.in.bal$year), FUN=sum)
motor.in.LA <- subset(NEI, SCC = idx, fips = '06037')
total.motor.in.LA <- aggregate(motor.in.LA$Emissions, by=list(Category=motor.in.LA$year), FUN=sum)

png(file="/Users/yahsintsai/Downloads/plot6.png")
par(mfrow=c(1,2))
plot(total.motor.in.bal, xlab = 'Year', ylab = 'Total PM2.5 Emission from Motor Vehicles in Baltimore', ylim = range(c(total.motor.in.LA$x, total.motor.in.bal$x)))
plot(total.motor.in.LA, xlab = 'Year', ylab = 'Total PM2.5 Emission from Motor Vehicles in LA', ylim = range(c(total.motor.in.LA$x, total.motor.in.bal$x)))
dev.off()
