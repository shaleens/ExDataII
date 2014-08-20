library(reshape2)
library("ggplot2")
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
SCC.coal <- SCC[grepl("Coal",SCC$EI.Sector,ignore.case=T),]
NEI.sourcedFromCoal <- merge(NEI, SCC.coal, by.y="SCC", by.x="SCC")
