library(xlsx)
library(stringr)
library("tmap")
library("leaflet")
library(dplyr)

setwd("D:/Development/Gun_rights/Massachusetts-LTC-Stats")

maTownShapefile <- "data/TOWNS_POLY.shp"

licenseData <- read.xlsx("data/Town_licensing.xlsx",sheetIndex=1,header=TRUE)

licenseData[,1] <- toupper(licenseData[,1])
licenseData[,1] <- gsub('Ã.', '', licenseData[,1])
licenseData[,1] <- gsub('Â.', '', licenseData[,1])
licenseData[,1] <- str_trim(licenseData[,1])

#All supporting files for the shape file must exist in that directory
mageo <- read_shape(file=maTownShapefile)
qtm(mageo)

str(mageo)
str(mageo@data)

# They're not. Change the town names to plain characters :
mageo@data$TOWN <- as.character(mageo@data$TOWN)

# Order each data set by county name
mageo <- mageo[order(mageo@data$TOWN),]
licenseData <- licenseData[order(licenseData$TOWN),]

#Test if the towns match
identical(mageo@data$TOWN,licenseData$TOWN)

#They do not.  So I am going to merge the two and update the License Data to figure out the differences and try again
#mergedTown.data <- merge(licenseData, mageo@data, by="TOWN", all.x = TRUE, all.y = TRUE)
#write.xlsx(x = data/mergedTown.data, file = "mergedTownData.xlsx", sheetName = "TownData", row.names = FALSE)

#Still not the same but plowing ahead anyway
mamap <- append_data(mageo, licenseData, key.shp = "TOWN", key.data="TOWN")

#Below map looks great.  However, need to update legend and change colors
png(file="maTownsIssuanceMap.png",width=800,height=600)
qtm(mamap, "Freedom.Index", title = "MA License To Carry - All Lawful Purposes", fill.palette = c("yellow", "red", "gray", "green", "black"), fill.title = "Freedom Index" )
tm_legend(text.size = 4)
dev.off()
#tm_shape(mamap)
