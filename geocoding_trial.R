# Date: 10/2/2014
# Author: Jess Seok

# clear the console
cat("\014")
# remove every object in the environment
rm(list = ls())

# install and load necessary packages
# install.packages("RDSTK")
# install.packages("plyr")

require(RDSTK)

# set working directory
setwd("U:/")

# read in raw data: this file happens to 
# contain segments of street address in separate columns
data <- read.csv("address.csv",as.is = TRUE)

# concatenate the address columns to be used as an input to the function
data$input <- paste(data$Address,data$City,data$State, data$zip,sep = " ")


# obtain latitude and longitude
lat <- list()
long <- list()

for (i in 1:nrow(data)) {
  lat[i] <-   tryCatch(street2coordinates(data$input[i])[3], error = function(e) "NA")
  long[i] <-   tryCatch(street2coordinates(data$input[i])[5], error = function(e) "NA")
  
}  

# convert the results to data frame
latlong <- as.data.frame(cbind(do.call(rbind,lat),do.call(rbind,long)))
latlong <- rename(latlong, c("V1" = "lat", "V2" = "long"))

data_output <- cbind(data,latlong)

# export the output
write.csv(data_output, "coordinates.csv")
