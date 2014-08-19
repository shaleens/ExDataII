library(reshape2)
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
NEI <- NEI[NEI$fips == '24510',]
NEI.melt <- melt(NEI,id="year", measure.vars="Emissions")
NEI.cast <- dcast(NEI.melt,year ~ variable, sum)
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
plot(NEI.cast$year, NEI.cast$Emissions, xlab = "Year", ylab = "Emissions", main="Emissions in Baltimore City")
lines(NEI.cast$year, NEI.cast$Emissions)
dev.off()