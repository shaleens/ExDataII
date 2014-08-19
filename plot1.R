library(reshape2)
NEI <- readRDS('exdata-data-NEI_data/summarySCC_PM25.rds')
NEI.split <- split(x=NEI, NEI$year)
getEmissionSum <- function(df) {
  return(sum(df$Emissions))
}
NEI.emissionsByYear <- sapply(NEI.split, getEmissionSum)
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')
plot(names(NEI.emissionsByYear),NEI.emissionsByYear, xlab="Year", ylab="Total emissions", main="Emissions by year")
lines(names(NEI.emissionsByYear),NEI.emissionsByYear)
dev.off()

