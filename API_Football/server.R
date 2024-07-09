

server <- function(input, output, session) {
  observeEvent(input$update, {
    endpoint <- input$endpoint
    league <- input$league
    season <- input$season
    team <- input$team
   
    if (endpoint == "players/topscorers") {
      # Fetch Top Scorers Data
      top_scorers_data <- get_football_data(endpoint, list(league = league, season = season))
      top_scorers_list <- as_tibble(top_scorers_data$response$player)
      top_scorers_stats <- bind_rows(lapply(top_scorers_data$response$statistics, as_tibble, .name_repair="unique"))
      top_scorers_df <- bind_cols(top_scorers_list, top_scorers_stats)
      
      # subset data
      filtered_scorers <- top_scorers_df |> filter(goals$total >= input$min_goals)
      output$top_scorers_table <- renderDataTable(filtered_scorers)
      
      # Plot Top Scorers Data
      output$topScorersPlot <- renderPlot({
        ggplot(filtered_scorers, aes_string(x = "name", y = input$varSelection)) +
          geom_bar(stat = "identity", fill = "skyblue") +
          coord_flip() +
          theme_minimal() +
          labs(x = "Player Name")
        })
    } else if (endpoint == "teams/statistics") {
      #fetch team stats data
      team_data <- get_football_data(endpoint, list(league = league, season = season, team = team))
      team_fixture <- as_tibble(team_data$response$fixtures)
      output$team_fixture_table <- renderDataTable(team_fixture)
     
      
    } 
    
  })
}
