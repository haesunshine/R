# Clear the console
cat("\014")
# Remove every object in the environment
rm(list = ls())

# load packages
lib <- c("rgdal", "ggplot2", "scales", "sp", "plyr", "dplyr", "gridExtra", "RColorBrewer", "maptools", "rjson", "rpart", "reshape", "shiny", "rgeos")
#sapply(lib, function(x) install.packages(x))
sapply(lib, function(x) require(x, character.only = TRUE))

# set working directory
setwd("C:/Users/HSeok/Downloads")

# hooray for nyc -- shp file source
#http://www.nyc.gov/html/dcp/html/bytes/districts_download_metadata.shtml#shfp

# nyc data
url <- "https://data.cityofnewyork.us/resource/g3vh-kbnw.json"
list <- fromJSON(file = url, method = 'C')
data <- data.frame(matrix(unlist(list), nrow = length(list), byrow = T), stringsAsFactors = FALSE)
names(data) <- names(unlist(list[[1]]))

# identify district names
data$SchoolDist <- as.numeric(gsub(" ", "", gsub("[A-z0]","", data$jurisdiction_name)))

# limit to columns of interest
toMatch <- c("SchoolDist", "percent_")
data <- data[,which(names(data) %in% (unique(grep(paste(toMatch, collapse = "|"), names(data), value = TRUE))))]

# import shp file
sd <- readOGR("nysd.shp", layer = "nysd")
sd@data$id = rownames(sd@data)

sd.points = fortify(sd, region = "id")
sd.df = join(sd.points, sd@data, by = "id")


# join to school data
data <- data.frame(sapply(data, function(x) as.numeric(x)))
data_joined <- left_join(sd.df, data, by = c("SchoolDist"))

# long/lats for labeling
labels <- aggregate(cbind(long, lat) ~ SchoolDist, data = sd.df, FUN = mean)


# plotting function

p1 <- ggplot(data_joined, aes(x = long, y = lat)) + 
      geom_polygon(aes(group = group, fill = percent_nreceives_public_assistance)) +
  #    geom_path(color="white") +
      coord_equal() +
      scale_fill_gradientn(colours = brewer.pal(9,"Blues"), 
                           label = percent,
                           name = "% Students on Public Assistance") +
      theme_bw() +
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            panel.border = element_blank()) +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text = element_blank(),
            axis.ticks = element_blank()) +
      theme(plot.title = element_text(size = 18, face = "bold")) +
      ggtitle("Snapshot: NYC School Districts") +
      theme(legend.position = "bottom",         
            legend.text = element_text(size = 7)) +
      geom_text(data = labels, aes(x = long, y = lat, label = SchoolDist), size = 4, color = "grey")

# print
png(filename = "nysd.png",
    width = 480, height = 480)
print(p1)
dev.off()
