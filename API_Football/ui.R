#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.


library(shiny)
library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(shinydashboard)

# Define UI

header <- dashboardHeader(title = "Football Data Dashboard")

siderbar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About", tabName = "about"),
    menuItem("Data_Download", tabName = "data_download"),
    menuItem("Data_Exploration", tabName = "data_exploration")
  )
)

body <- dashboardBody(
    tabItems(
      tabItem(tabName = "about",
              fluidRow(
                box(title = "This App", status = "primary", solidHeader = TRUE,
                    "AAAA"
                )
              ),
              
              fluidRow(
                box(title = "Data Source", status = "primary", solidHeader = TRUE,
                    "BBBB"
                ),
                box(title = "Each Tap", status = "primary", solidHeader = TRUE,
                    "CCCC"
                )
              )
      ),
      
      tabItem(tabName = "data_download",
              fluidRow(
                box(title = "Endpoint", status = "primary", solidHeader = TRUE,
                    selectInput("endpoint", "Select endpoint", choices = c("players/topscorers", "teams/statistics"))),
             
                box(title = "Parameter Input", status = "primary", solidHeader = TRUE,
                    textInput("league", "League", value = "39"),
                    textInput("season", "Season", value = "2022"),
                    conditionalPanel(condition = "input.endpoint == 'teams/statistics'",
                                     textInput("team", "Team", value = "33")),
                    conditionalPanel(condition = "input.endpoint == 'players/topscorers'",
                                    sliderInput("min_goals", "Minimum Goals", min = 0, max = 30, value = 0)),
                    actionButton("update", "Update Data")
                    )
                ),
              
              fluidRow(
                box(title = "Data overview", status = "primary", solidHeader = TRUE,
                    conditionalPanel(condition = "input.endpoint == 'players/topscorers'",
                                     dataTableOutput("top_scorers_table"))
                    )
                )
              ),
              
      
      tabItem(tabName = "data_exploration", 
              fluidRow(
                conditionalPanel(condition = "input.endpoint == 'players/topscorers'",
                  box(title = "Shot and goal summary of Top Scorers", 
                    selectInput("varSelection", "Variables", choices = c("Total shots"="shots$total", "Shots On"="shots$on", "Total goals"="goals$total")),
                    plotOutput("topScorersPlot", height = 350)
                )
               )
              ),
              
              fluidRow(
                box(title = "EE", status = "primary", solidHeader = TRUE,
                    "BBBB"
                ),
                box(title = "RR", status = "primary", solidHeader = TRUE,
                    "CCCC"
                )
              )
      )
    )
)

ui <- dashboardPage(header, siderbar, body)
  
  
  
  
    
