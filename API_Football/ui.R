#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.


library(shiny)
library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)

#
# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)
