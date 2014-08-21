library(reshape2)
library("ggplot2")
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Classes considered
# Mobile - On-Road Gasoline Light Duty Vehicles     
# Mobile - On-Road Gasoline Heavy Duty Vehicles     
# Mobile - On-Road Diesel Light Duty Vehicles       
# Mobile - On-Road Diesel Heavy Duty Vehicles 
SCC.vehicles <- SCC[grepl("Vehicles",SCC$EI.Sector,ignore.case=T),]
NEI.sourcedFromVehicles <- merge(NEI, SCC.vehicles, by.y="SCC", by.x="SCC")
NEI.melt <- melt(NEI.sourcedFromVehicles,id="year", measure.vars="Emissions")
NEI.cast <- dcast(NEI.melt, year ~ variable, sum)

png(filename = 'plot5.png', width = 480, height = 480, units = 'px')
qplot(year, Emissions, data = NEI.cast, geom = c("point","line"), main = "Emissions sources from motor vehicles")
dev.off()
