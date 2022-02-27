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

Pop <- c(1570,854,850,653,543,533,469,463,379,348,343,242,206,189,160,154,154,115,
         104,96,94,90,89,85,82,66,61,57,52,49.87,44.32,30.47,26.32,25,25,23.5,23.4,23.3,23,20,16.43,16.2,15.5,14.6,14.5,12.3,12,10,8.5)

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
        plot.title = element_text(size = 25, hjust = .5, vjust = -3, family = "Puritan"),
        plot.subtitle = element_text(size = 14, hjust = .03, vjust = -15, family = "serif"),
        axis.text.x = element_text(vjust = 5, family = "serif", size = 14),
        axis.text.x.top = element_text(margin = margin(t = 20, b = -28)),
        axis.text.y = element_text(hjust = 0, size = 14, vjust = .45, margin = margin(l = 30, r = -130.5)),
        axis.text = element_text(family = "serif"),
        axis.ticks = element_blank(),
        panel.border = element_rect(fill = NA, color = "black", size = 1.5),
        aspect.ratio = 1.2,
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        plot.margin = unit(c(0,-10,.6,-10), "cm"))
dev.off()
