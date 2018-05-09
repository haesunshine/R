# date:
# author:
# data source:

cat("\014")
rm(list = ls())

###############################################################
#install.packages("dplyr")
require(dplyr)
require(plyr)

setwd("C:/Users/HSeok/Downloads")

# 2013 hospital utilization data; csv limited to the sheet which contains section 1-4
hosp13 <- read.csv("Hosp13.csv", as.is = TRUE)
hosp13 <- hosp13[-c(1:3),c(1:17,156:203)]
hosp13 <- cbind(rep(2013, nrow(hosp13)), hosp13)
colnames(hosp13)[1] <- "year"
colnames(hosp13)[37] <- "minor_not_admitted"
colnames(hosp13)[38] <- "minor_admitted"
colnames(hosp13)[39] <- "low_not_admitted"
colnames(hosp13)[40] <- "low_admitted"
colnames(hosp13)[41] <- "moderate_not_admitted"
colnames(hosp13)[42] <- "moderate_admitted"
colnames(hosp13)[43] <- "severe_wo_threat_not_admitted"
colnames(hosp13)[44] <- "severe_wo_threat_admitted"
colnames(hosp13)[45] <- "severe_w_threat_not_admitted"
colnames(hosp13)[46] <- "severe_w_threat_admitted"

# 2012 hospital utilization data; csv limited to the sheet which contains section 1-4
hosp12 <- read.csv("Hosp12.csv", as.is = TRUE)
hosp12 <- hosp12[-c(1:3),c(1:17,156:203)]
hosp12 <- cbind(rep(2012, nrow(hosp12)), hosp12)
colnames(hosp12)[1] <- "year"
colnames(hosp12)[37] <- "minor_not_admitted"
colnames(hosp12)[38] <- "minor_admitted"
colnames(hosp12)[39] <- "low_not_admitted"
colnames(hosp12)[40] <- "low_admitted"
colnames(hosp12)[41] <- "moderate_not_admitted"
colnames(hosp12)[42] <- "moderate_admitted"
colnames(hosp12)[43] <- "severe_wo_threat_not_admitted"
colnames(hosp12)[44] <- "severe_wo_threat_admitted"
colnames(hosp12)[45] <- "severe_w_threat_not_admitted"
colnames(hosp12)[46] <- "severe_w_threat_admitted"

# 2011 hospital utilization data; csv limited to the sheet which contains section 1-4
hosp11 <- read.csv("Hosp11.csv", as.is = TRUE)
hosp11 <- hosp11[-c(1:3),c(1:17,147:194)]
hosp11 <- cbind(rep(2011, nrow(hosp11)), hosp11)
colnames(hosp11)[1] <- "year"
colnames(hosp11)[37] <- "minor_not_admitted"
colnames(hosp11)[38] <- "minor_admitted"
colnames(hosp11)[39] <- "low_not_admitted"
colnames(hosp11)[40] <- "low_admitted"
colnames(hosp11)[41] <- "moderate_not_admitted"
colnames(hosp11)[42] <- "moderate_admitted"
colnames(hosp11)[43] <- "severe_wo_threat_not_admitted"
colnames(hosp11)[44] <- "severe_wo_threat_admitted"
colnames(hosp11)[45] <- "severe_w_threat_not_admitted"
colnames(hosp11)[46] <- "severe_w_threat_admitted"

# 2010 hospital utilization data; csv limited to the sheet which contains section 1-4
hosp10 <- read.csv("Hosp10.csv", as.is = TRUE)
hosp10 <- hosp10[-c(1:3),c(1:17,147:194)]
hosp10 <- cbind(rep(2010, nrow(hosp10)), hosp10)
colnames(hosp10)[1] <- "year"
colnames(hosp10)[37] <- "minor_not_admitted"
colnames(hosp10)[38] <- "minor_admitted"
colnames(hosp10)[39] <- "low_not_admitted"
colnames(hosp10)[40] <- "low_admitted"
colnames(hosp10)[41] <- "moderate_not_admitted"
colnames(hosp10)[42] <- "moderate_admitted"
colnames(hosp10)[43] <- "severe_wo_threat_not_admitted"
colnames(hosp10)[44] <- "severe_wo_threat_admitted"
colnames(hosp10)[45] <- "severe_w_threat_not_admitted"
colnames(hosp10)[46] <- "severe_w_threat_admitted"

# 2009 hospital utilization data; csv limited to the sheet which contains section 1-4
hosp09 <- read.csv("Hosp09.csv", as.is = TRUE)
hosp09 <- hosp09[-c(1:3),c(1:17,147:194)]
hosp09 <- cbind(rep(2009, nrow(hosp09)), hosp09)
colnames(hosp09)[1] <- "year"
colnames(hosp09)[37] <- "minor_not_admitted"
colnames(hosp09)[38] <- "minor_admitted"
colnames(hosp09)[39] <- "low_not_admitted"
colnames(hosp09)[40] <- "low_admitted"
colnames(hosp09)[41] <- "moderate_not_admitted"
colnames(hosp09)[42] <- "moderate_admitted"
colnames(hosp09)[43] <- "severe_wo_threat_not_admitted"
colnames(hosp09)[44] <- "severe_wo_threat_admitted"
colnames(hosp09)[45] <- "severe_w_threat_not_admitted"
colnames(hosp09)[46] <- "severe_w_threat_admitted"

all.data <- rbind(hosp09,hosp10,hosp11,hosp12,hosp13)

colnames(all.data) <- tolower(colnames(all.data))
colnames(all.data)[3] <- "name"
colnames(all.data)[4] <- "address1"
colnames(all.data)[5] <- "address2"
colnames(all.data)[6] <- "city"
colnames(all.data)[7] <- "zip"
colnames(all.data)[8] <- "phone"
colnames(all.data)[9] <- "admin.name"
colnames(all.data)[10] <- "in.operation"
colnames(all.data)[11] <- "op.beg.date"
colnames(all.data)[12] <- "op.end.date"
colnames(all.data)[13] <- "parent.name"
colnames(all.data)[14] <- "parent.address.1"
colnames(all.data)[15] <- "parent.address.2"
colnames(all.data)[16] <- "parent.city"
colnames(all.data)[17] <- "parent.state"
colnames(all.data)[18] <- "parent.zip"
colnames(all.data)[19] <- "trauma_ctr_desig"
colnames(all.data)[20] <- "trauma_ctr_pediatric"
colnames(all.data)[21] <- "parent.zip"
colnames(all.data)[22] <- "parent.zip"

write.csv(all.data,"OSHPD_2009-2013.csv")

