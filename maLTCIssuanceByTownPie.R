library(dplyr)
library(ggplot2)
library(xlsx)
library(ggthemes) 


setwd("D:/Development/Gun_rights/Massachusetts-LTC-Stats")

licCri <- read.xlsx("data/maMergedCrimeLicense.xlsx",sheetIndex=1,header=TRUE)

by_index <- group_by(licCri, Freedom.Index)
countByIndex <- summarize(by_index,count=n())
countByIndex <- as.data.frame(countByIndex)

#p <- qplot(Freedom.Index, data=licCri, geom="bar", fill=Freedom.Index, xlab = "Breakdown of Towns", ylab = "Issuance of LTC All Lawful Purposes") 
#p <- p + ggtitle("Freedom Index")
#p + scale_fill_manual(name="", values = c("Usually Issue" = "darkgreen", "May Not Issue" = "red", "Unknown" = "gray", "Inconsistent Issue" = "orange", "Will Not Issue" = "black"))

pie <- ggplot(countByIndex, aes(x="", y=count, fill=Freedom.Index)) + geom_bar(width = 1, stat = "identity")
pie <- pie + coord_polar("y", start=0) 
pie <- pie + scale_fill_manual(name="", values = c("Usually Issue" = "darkgreen", "May Not Issue" = "red", "Unknown" = "gray", "Inconsistent Issue" = "orange", "Will Not Issue" = "black")) 
pie <- pie +   geom_text(aes(y = count/3 + c(0, cumsum(count)[-length(count)]), label = count), size=6)
pie <- pie + labs(title="MA Town Breakdown of LTC All Lawful Purposes Issuance", x ="", y = "Total of 352 Towns in Massachusetts") + theme_minimal() + theme(
  axis.title.x = element_text(size=12, face="bold"),
  axis.title.y = element_blank(),
  panel.border = element_blank(),
  panel.grid=element_blank(),
  axis.ticks = element_blank(),
  plot.title=element_text(size=14, face="bold")
)

png(file="maTownsIssuancePie.png",width=800,height=600)
pie
dev.off()