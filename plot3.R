library(reshape2)
library("ggplot2")
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')

NEI.split <- split(NEI, NEI$type)

NEI.nonRoad.melt <- melt(NEI.split[["NON-ROAD"]],id="year", measure.vars="Emissions")
NEI.nonRoad.cast <- dcast(NEI.nonRoad.melt,year ~ variable, sum)

NEI.nonPoint.melt <- melt(NEI.split$NONPOINT,id="year", measure.vars="Emissions")
NEI.nonPoint.cast <- dcast(NEI.nonPoint.melt,year ~ variable, sum)

NEI.onRoad.melt <- melt(NEI.split[["ON-ROAD"]],id="year", measure.vars="Emissions")
NEI.onRoad.cast <- dcast(NEI.onRoad.melt,year ~ variable, sum)

NEI.point.melt <- melt(NEI.split$POINT,id="year", measure.vars="Emissions")
NEI.point.cast <- dcast(NEI.point.melt,year ~ variable, sum)

g <- ggplot() + geom_line(aes(year, Emissions, col="non-Road"), NEI.nonRoad.cast)
g <- g + geom_line(aes(year, Emissions, col="non-Point"), NEI.nonPoint.cast)
g <- g + geom_line(aes(year, Emissions, col="on-Road"), NEI.onRoad.cast)
g <- g + geom_line(aes(year, Emissions, col="point"), NEI.point.cast)
g <- g + theme(legend.title=element_blank())
g <- g + labs(title = "Comparison between diferrent types vis-a-vis emissions")

ggsave("plot3.png", plot = g)