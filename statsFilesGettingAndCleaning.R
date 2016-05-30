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

##1.  Is there an income difference between green and red towns?
##2.  Is there a political leaning in green versrs red towns?
##3.  Is there a difference in voilent crime in red verses green towns?
##4.  ***Data not captured but... 2010 census data for racial makeup in red verse green towns?***
maIncomeData <- read.xlsx("data/MA_Town_income_levels.xlsx",sheetIndex=1,header=TRUE)
maIncomeData[,2] <- str_trim(maIncomeData[,2])
maIncomeData[,2] <- toupper(maIncomeData[,2])
head(maIncomeData)
tail(maIncomeData)
str(maIncomeData)
mergedTownLicIncome.data <- merge(licenseData, maIncomeData, by="TOWN", all.x = TRUE, all.y = TRUE)
write.xlsx(x = mergedTownLicIncome.data, file = "data/mergedTownLicIncome.xlsx", sheetName = "TownData", row.names = FALSE)

maVoterData <- read.xlsx("data/Massachusetts_voter_enrollment_2015.xlsx",sheetIndex=2,header=TRUE)
maVoterData[,1] <- str_trim(maVoterData[,1])
maVoterData[,1] <- toupper(maVoterData[,1])
head(maVoterData)
tail(maVoterData)
str(maVoterData)
mergedTownLicVoter.data <- merge(licenseData, maVoterData, by="TOWN", all.x = TRUE, all.y = TRUE)
write.xlsx(x = mergedTownLicVoter.data , file = "data/mergedTownLicVoter.xlsx", sheetName = "TownData", row.names = FALSE)

maCrimeData <- read.xlsx("data/MA_2014_crime.xls",sheetIndex=1,header=TRUE)
maCrimeData[,1] <- str_trim(maCrimeData[,1])
maCrimeData[,1] <- toupper(maCrimeData[,1])
head(maCrimeData)
tail(maCrimeData)
str(maCrimeData)
#mergedTown.data <- merge(licenseData, townData, by="TOWN", all.x = TRUE, all.y = TRUE)
#write.xlsx(x = mergedTown.data, file = "mergedTownData.xlsx", sheetName = "TownData", row.names = FALSE)
#maMergedCrimeLicense.data <- merge(licenseData, maCrimeData, by="TOWN", all.x = TRUE, all.y = TRUE)
#(x = maMergedCrimeLicense.data, file = "maMergedCrimeLicense.xlsx", sheetName = "maMergedCrimeLicense", row.names = FALSE)
licCri <- read.xlsx("data/maMergedCrimeLicense.xlsx",sheetIndex=1,header=TRUE)
#total number merged is 348
#MA Towns file has 352 rows
#MA License file has 351 



