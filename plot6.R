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

NEI.sourcedFromVehicles.baltimore = NEI.sourcedFromVehicles[NEI.sourcedFromVehicles$fips == '24510',]
NEI.baltimore.melt <- melt(NEI.sourcedFromVehicles.baltimore,id="year", measure.vars="Emissions")
NEI.baltimore.cast <- dcast(NEI.baltimore.melt, year ~ variable, sum)

NEI.sourcedFromVehicles.laCounty = NEI.sourcedFromVehicles[NEI.sourcedFromVehicles$fips == '06037',]
NEI.laCounty.melt <- melt(NEI.sourcedFromVehicles.laCounty,id="year", measure.vars="Emissions")
NEI.laCounty.cast <- dcast(NEI.laCounty.melt, year ~ variable, sum)


png(filename = 'plot6.png', width = 480, height = 480, units = 'px')
g <- ggplot() + geom_line(aes(year, Emissions, col="Baltimore"), NEI.baltimore.cast)
g <- g + geom_line(aes(year, Emissions, col="LA County"), NEI.laCounty.cast)
g <- g + theme(legend.title=element_blank())
g <- g + labs(title = "Emissions by motor vehicles")
g
dev.off()

