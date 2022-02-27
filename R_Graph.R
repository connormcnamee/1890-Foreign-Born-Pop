# load in packages
library(tidyverse)
library(ggthemes)
library(gtable)
library(showtext)
# read in the dataset
States <- c("New York", "Pennsylvania", "Illinois", "Massachusetts",
            "Michigan", "Wisconsin", "Minnesota", "Ohio", "California",
            "New Jersey", "Iowa", "Missouri", "Nebraska", "Connecticut",
            "Texas", "Kansas", "Indiana", "Rhode Island", "Maryland",
            "South Dakota", "Washington", "North Dakota", "Maine", "Colorado",
            "New Hampshire", "Kentucky", "Utah", "Louisiana", "Oregon",
            "Vermont", "Montana", "Florida", "Tennessee", "West Virginia",
            "Arizona", "Dis. Of Col.", "Virginia", "Idaho", "Wyoming", "Nevada",
            "Arkansas", "Alabama", "Delaware", "New Mexico", "Georgia",
            "Mississippi", "South Carolina", "North Carolina", "Oklahoma")

Pop <- c(1567,848,840,645,540,530,470,470,385,346,342,234,200,190,153,148,146,110,
         100,94,90,84,87,84,81,75,70,65,60,56,44,23,21,20,20,18,15,14,12,10,10,10,9,8,8,7,6,5,4)

Foreign_Born_Pop <- tibble::tibble(States,Pop)

font_add_google("Puritan", "Puritan")
showtext_auto()

png("Pop-Density.png",width=1800,height=2000)
ggplot(Foreign_Born_Pop) +
  # order states by high to low population, and set a lower width of the bars
  geom_col(aes(y = reorder(States,Pop), x = Pop), width = .45, color = "black", fill = "#2e2c26") + 
  labs(y = NULL, x = "(in thousands)", title = "Foreign Born Population, by States and Territories: 1890", subtitle = "States") + 
  annotate("segment", x = 0, xend = 0, y = 0, yend = 52) +
  annotate("segment", x = seq(100,1500,100), xend = seq(100,1500,100), y = 0, yend = 49.7) +
  annotate("segment", x = -335, xend = 1635, y = 49.7, yend = 49.7) +
  geom_col(aes(y = reorder(States,Pop), x = Pop), width = .45, color = "black", fill = "#2e2c26") +
  # creates the theme that matches the original chart
  theme_linedraw(base_line_size = .6) +
  #scale back the x axis so it doesn't go so far off to the right
  coord_cartesian(xlim = c(-75,1540), ylim = c(.5,50.1)) +
  # change x-axis labels to every 100, and move the labels to the top
  scale_x_continuous(breaks = seq(100,1500,100), position = "top") +
  #change size, position, and fonts of the text in the chart
  theme(axis.title.x.top = element_text(size = 14, family = "serif", vjust = 0),
        axis.title.y = element_text(size = 14, hjust = 0, vjust = .5, family = "serif"),
        plot.title = element_text(size = 18, hjust = .5, vjust = -3, family = "Puritan"),
        plot.subtitle = element_text(size = 14, hjust = .03, vjust = -15, family = "serif"),
        axis.text.x = element_text(vjust = 5, family = "serif", size = 14),
        axis.text.x.top = element_text(margin = margin(t = 20, b = -28)),
        axis.text.y = element_text(hjust = 0, size = 14, vjust = .45, margin = margin(l = 30, r = -130.5)),
        axis.text = element_text(family = "serif"),
        axis.ticks = element_blank(),
        panel.border = element_rect(fill = NA, color = "black"),
        aspect.ratio = 1.2,
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        plot.margin = unit(c(0,-10,.6,-10), "cm"))
dev.off()
