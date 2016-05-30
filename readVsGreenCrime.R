library(dplyr)
library(ggplot2)
library(xlsx)
library(ggthemes) 

setwd("D:/Development/Gun_rights/Massachusetts-LTC-Stats")

licCri <- read.xlsx("data/maMergedCrimeLicense.xlsx",sheetIndex=1,header=TRUE)

#Filter only those licenses that are RED
redLic <- filter(licCri, FIREARMS_LICENSE_DIFFICULTY == 3)
#Filtering out Boston to remove the outlyer
redLic <- filter(redLic , TOWN != "BOSTON")
redLicViolent <- filter(redLic, Violent.crime != "NA")
redLicViolentTop10 <- top_n(redLicViolent, 10, Violent.crime)
#Replacing the factor with a number
redLicViolentTop10[,5] <- as.numeric(as.character(redLicViolentTop10[,5]))
redLicViolentTop10 <- arrange(redLicViolentTop10, desc(Violent.crime)) 



#Filter only those licenses that are Green
greenLic <- filter(licCri, FIREARMS_LICENSE_DIFFICULTY == 1)
greenLicViolent <- filter(greenLic, Violent.crime != "NA")
greenLicViolentTop10 <- top_n(greenLicViolent, 10, Violent.crime)
#Replacing the factor with a number
greenLicViolentTop10[,5] <- as.numeric(as.character(greenLicViolentTop10[,5]))
greenLicViolentTop10 <- arrange(greenLicViolentTop10, desc(Violent.crime), Population) 


