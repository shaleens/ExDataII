library(reshape2)
library("ggplot2")
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
SCC.coal <- SCC[grepl("Coal",SCC$EI.Sector,ignore.case=T),]
NEI.sourcedFromCoal <- merge(NEI, SCC.coal, by.y="SCC", by.x="SCC")
NEI.melt <- melt(NEI.sourcedFromCoal,id="year", measure.vars="Emissions")
NEI.cast <- dcast(NEI.melt, year ~ variable, sum)

png(filename = 'plot4.png', width = 480, height = 480, units = 'px')
qplot(year, Emissions, data = NEI.cast, geom = c("point","line"), main = "Emissions sourced from coal")
dev.off()