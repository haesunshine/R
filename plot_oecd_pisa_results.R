# Clear the console
cat("\014")
# Remove every object in the environment
rm(list = ls())

# require packages
lib <- c("XLConnect", "reshape", "scales", "dplyr", "ggplot2", "gtable", "grid", "RColorBrewer", "gridExtra", "extrafont")
sapply(lib, function(x) require(x, character.only = TRUE))

# set WD
mywb <- setwd("C:/Users/HSeok/Downloads/")

##################################################
##################################################

# load data
wb <- loadWorkbook(paste0(mywb, "/PISA2012_Gender_Ch1_Tab_ENG", ".xlsx"))

# imports PISA 2012 math scores by gender
data <- readWorksheet(wb, sheet = "table 1.3a")
data <- data[-c(1:15), c(1, 2, 4)]
names(data) <- c("country", "boys", "girls")
data$diff <- as.numeric(data$boys) - as.numeric(data$girls)


# order by greatest discrepancies between boys and girls 
data <- arrange(data, -diff)
data <- data[c(1:20), ]
data$country <- factor(data$country, levels = (data$country[order(data$diff)]))


# melt
data_long <- data[, c(1,4)]

# change to factor
data_long$country <- factor(data_long$country, levels = rev(data$country[order(data$country)]))


# plot!

  p1 <- ggplot(data_long, aes(x = country, y = diff)) + 
        geom_bar(stat = 'identity', position = 'dodge', fill = "steelblue1") +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
            panel.grid.major = element_blank(),
                panel.border = element_blank()) +
      theme(axis.line = element_line(size = 0.5, colour = "black"),
                axis.title = element_blank(), 
                axis.text.y = element_text(size = 20),
                axis.text.x = element_text(angle = 40, vjust= 0.7, size = 20)) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_continuous(limits = c(0, 30), breaks = seq(0, 30, 5), expand = c(0,0)) +
      theme(text = element_text(family = "Arial")) +
      ggtitle("Countries with the Largest Gender Gaps in PISA Math Scores") +
      theme(plot.title = element_text(size = 32, face = "bold")) 
          
##################################################
# PLOT: countries where girls are best performing
##################################################

data <- readWorksheet(wb, sheet = "table 1.3a")
data <- data[-c(1:15), c(1, 2, 4)]
names(data) <- c("country", "boys", "girls")
data$boys <- as.numeric(data$boys)
data$girls <- as.numeric(data$girls)

# order by best performances by girls
data <- arrange(data, -girls)
data <- data[c(1:20), ]
data$country <- factor(data$country, levels = rev(data$country[order(data$girls)]))

# melt
data_long <- melt(data, id = "country")

# change to factor
data_long$country <- factor(data_long$country, levels = (data$country[order(data$country)]))

p2 <- ggplot(data_long, aes(x = country, y = value)) + 
  geom_bar(stat = 'identity', position = 'dodge', aes(fill = variable, group = factor(variable))) +
  scale_fill_manual(values = c("#FC8D59", "#99D594"),
                    name = "",
                    labels = c("", "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank()) +
  theme(axis.line = element_line(size = 0.5, colour = "black"),
        axis.title = element_blank(), 
        axis.text.y = element_text(size = 20),
        axis.text.x = element_text(angle = 40, vjust= 0.7, size = 20)) +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 650), breaks = seq(0, 600, 100), expand = c(0,0)) +
  theme(legend.position = "none") +
  theme(text = element_text(family = "Arial")) 

##################################################
# PLOT: countries where girls are worst performing
##################################################

data <- readWorksheet(wb, sheet = "table 1.3a")
data <- data[-c(1:15), c(1, 2, 4)]
names(data) <- c("country", "boys", "girls")
data$boys <- as.numeric(data$boys)
data$girls <- as.numeric(data$girls)

# order by worst performances by girls
data <- arrange(data, girls)
data <- data[c(1:20), ]
data$country <- factor(data$country, levels = rev(data$country[order(data$girls)]))

# melt
data_long <- melt(data, id = "country")

# change to factor
data_long$country <- factor(data_long$country, levels = (data$country[order(data$country)]))

p3 <- ggplot(data_long, aes(x = country, y = value)) + 
  geom_bar(stat = 'identity', position = 'dodge', aes(fill = variable, group = factor(variable))) +
  scale_fill_manual(values = c("#FC8D59", "#99D594"),
                    name = "2012 PISA Score in Math",
                    labels = c("Boys", "Girls")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank()) +
  theme(axis.line = element_line(size = 0.5, colour = "black"),
        axis.title = element_blank(), 
        axis.text.y = element_text(size = 20),
        axis.text.x = element_text(angle = 40, vjust= 0.7, size = 20)) +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 650), breaks = seq(0, 600, 100), expand = c(0,0)) +
  theme(legend.position = "bottom",
        legend.key.width = unit(3, "cm"),
        legend.text = element_text(size = 30, face = "bold")) +
  theme(text = element_text(family = "Arial")) 



jpeg("mathscores.jpg", width = 22, height = 32, units = 'in', res = 300)
pushViewport(viewport(layout = grid.layout(2, 1)))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
dev.off() 


jpeg("mathgap.jpg", width = 22, height = 16, units = 'in', res = 300)
print(p1)
dev.off() 



