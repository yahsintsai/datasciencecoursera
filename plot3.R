setwd('/Users/yahsintsai/Downloads/exdata-data-NEI_data')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(patchwork)
# 1). POINT
point <- subset(NEI, type=='POINT' & fips=='24510')
total.by.point <- aggregate(point$Emissions, by=list(Category=point$year), FUN=sum)
colnames(total.by.point) <- c('year', 'sum')
# 2). NONPOINT
nonpoint <- subset(NEI, type=='NONPOINT' & fips=='24510')
total.by.nonpoint <- aggregate(nonpoint$Emissions, by=list(Category=nonpoint$year), FUN=sum)
colnames(total.by.nonpoint) <- c('year', 'sum')
# 3). ONROAD
onroad <- subset(NEI, type=='ON-ROAD' & fips=='24510')
total.by.onroad <- aggregate(onroad$Emissions, by=list(Category=onroad$year), FUN=sum)
colnames(total.by.onroad) <- c('year', 'sum')
# 4). NONROAD
nonroad <- subset(NEI, type=='NON-ROAD' & fips=='24510')
total.by.nonroad <- aggregate(nonroad$Emissions, by=list(Category=nonroad$year), FUN=sum)
colnames(total.by.nonroad) <- c('year', 'sum')

png(file="/Users/yahsintsai/Downloads/plot3.png")
p1 <- ggplot(total.by.point, aes(x = year, y = sum)) + geom_point() + labs(title = "POINT")
p2 <- ggplot(total.by.nonpoint, aes(x = year, y = sum)) + geom_point() + labs(title = "NONPOINT")
p3 <- ggplot(total.by.onroad, aes(x = year, y = sum)) + geom_point() + labs(title = "ONROAD")
p4 <- ggplot(total.by.nonroad, aes(x = year, y = sum)) + geom_point() + labs(title = "NONROAD")
p1 + p2 + p3 + p4
dev.off()