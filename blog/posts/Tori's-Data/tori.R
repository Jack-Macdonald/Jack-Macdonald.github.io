#install.packages("readJDX")            <-
#install.packages("plotly")             <- Install if needed
#install.packages("ggplot2")            <- 
library(readJDX)
library(plotly)
library(ggplot2)

######################################################
## I am not entirely sure what needs to be graphed  ##                 
## it was not as intutive as I hoped                ##
######################################################

## getting data ##
data <- readJDX("Jul06-2023_5.dx", SOFC = T)

## creating a data frame of just the real and imaginary data ##
real <- data$real
imagine <- data$imaginary

real$type <- "real"
imagine$type <- "imaginary"

type <- rbind(real,imagine)

## ploting both type, lots of overlap ##
ggplot(type, aes(x, y, col = type))+
  geom_point(pch = "x")

## creating a 3d plot of the real and imaginary data ##
## its been a while since I have taken calculus... ##
## so I don't remember how that works, I tried my best ##
real_plot <- plot_ly(real, x = ~x, y = ~y, z = ~0, type = 'scatter3d', mode = 'markers',
                     marker = list(color = 'blue', size = 4), name = "Real")

imaginary_plot <- plot_ly(imagine, x = 0, y = ~y, z = ~x*(-1), type = 'scatter3d', mode = 'markers',
                          marker = list(color = 'red', size = 4), name = "Imaginary")

combined_plot <- subplot(real_plot, imaginary_plot, nrows = 1)
layout(combined_plot, scene = list(aspectmode = "cube"))

