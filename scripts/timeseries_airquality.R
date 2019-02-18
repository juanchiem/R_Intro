library(RColorBrewer)
library(tidyverse)

data(airquality)
airquality$Month <- factor(airquality$Month,labels = c("May", "Jun", "Jul", "Aug", "Sep"))
air <- airquality[which(airquality$Month == "Jul" |
                          airquality$Month == "Aug" |
                          airquality$Month == "Sep"), ]

air$Temp.f <- factor(
  ifelse(air$Temp > mean(air$Temp), 1,0),
  labels = c("Low temp", "High temp")
  )


ggplot(air, aes(x = Month, y = Ozone, fill = Temp.f)) +
  geom_boxplot(alpha=0.7) +
  scale_y_continuous(name = "Mean ozone in\nparts per billion",
                     breaks = seq(0, 175, 25),
                     limits=c(0, 175)) +
  scale_x_discrete(name = "Month") +
  ggtitle("Boxplot of mean ozone by month") +
  theme_bw() +
  theme(plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        text = element_text(size = 12, family = "Tahoma"),
        axis.title = element_text(face="bold"),
        axis.text.x=element_text(size = 11)) +
  scale_fill_brewer(palette = "Accent")
