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
                box(img(src = 'P2.png', align = "left")),
                box(img(src = 'P1.png', align = "right"))
                ),
              
              fluidRow(
                box(title = "Purpose", status = "primary", solidHeader = TRUE,
                    h3("Welcome!"),
                    h4("The App can get the information about Football
                    Leagues & Cups.")
                ),
                box(title = "Data Source", status = "primary", solidHeader = TRUE,
                    h4("The data is queried from API-FOOTBALL, https://dashboard.api-football.com"),
                    h4("Two endpoints will be queried in this App: 
                       players/topscorers will get the 20 best players for a league and season;
                       teams/statistics will returns the statistics of a team 
                       in relation to a given competition and season.")
                ),
                box(title = "Each Tab", status = "primary", solidHeader = TRUE,
                    h3("There are three tabs in the left sidebar:"),
                    h4("About tab: provide the basic introduction of purpose and data source of the App"),
                    h4("Data_Download tab: allow user to specify the endpoint, subset, display and save the data set"),
                    h4("About tab: allow user to choose variables that showing the summary of data set")
                ),
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
                                     ),
                                 
                                 box(title = "Mean value of Top Scores' stats",
                                     dataTableOutput("topScorers_mean_table")
                                     )
                                 )
                ),
              
              fluidRow(
                conditionalPanel(condition = "input.endpoint == 'players/topscorers'",
                                 box(title = "Positon and team information of Top Scores",
                                     dataTableOutput("topScores_position_team_table")
                                     ),
                                 box(title = "Correlation between shots and goals", 
                                     selectInput("X", "X", choices = c("Total shots"="shots$total", "Shots On"="shots$on", "Total goals"="goals$total")),
                                     selectInput("Y", "Y", choices = c("Total shots"="shots$total", "Shots On"="shots$on", "Total goals"="goals$total")),
                                     plotOutput("shotgoalPlot", height = 350)
                                     )
                                 )
                )
              )
      )
    )

ui <- dashboardPage(header, siderbar, body)
  
  
  
  
    
