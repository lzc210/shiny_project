library(shiny)
library(dplyr)
library(ggplot2)
library(ggrepel)

starcraft = starcraft[starcraft$TotalHours < 1000000,]
names(starcraft)
sapply(starcraft, class)
league_index = sort(unique(starcraft$LeagueIndex))
names(league_index) = c('Bronze','Silver','Gold', 'Diamond','Master','GrandMaster','Professional leauges')
starcraft = starcraft %>% mutate(., high_level = LeagueIndex > 5)

function(input, output, session){
  #output$worker_range = reactive({input$macro})
  # starcraft_filter = reactive({
  #   starcraft %>% filter(., WorkersMade > input$macro)
  # })
  output$mechanics = renderPlot(
    starcraft %>% filter(., WorkersMade*MaxTimeStamp > input$macro[1] & WorkersMade*MaxTimeStamp < input$macro[2] & 
                          TotalHours > input$hour[1] & TotalHours < input$hour[2]
                         ) %>%
      ggplot(., aes(x = APM, y = UniqueUnitsMade)) + geom_point(aes(color = LeagueIndex))
      + ggtitle('APM versus Strategy')
  )
    output$apm = renderPlot(
      starcraft %>% group_by(., LeagueIndex)
      # choices = list('Average' = 1, 'Standard Deviation' = 2,
      #                'Max' = 3, 'Min' = 4))
      %>% summarise(., Average_APM = mean(APM))
      %>% ggplot(., aes(x = LeagueIndex, y = Average_APM, z = '')) + geom_bar(stat = 'identity')
    )
    output$strat = renderPlot(
      starcraft %>% group_by(., LeagueIndex)
      # choices = list('Average' = 1, 'Standard Deviation' = 2,
      #                'Max' = 3, 'Min' = 4))
      %>% summarise(., Average_Strategy = mean(UniqueUnitsMade))
      %>% ggplot(., aes(x = LeagueIndex, y = Average_Strategy, z = '')) + geom_bar(stat = 'identity')
    )
  # else:
  #   output$stat = renderPlot(
  #     starcraft %>% group_by(., LeagueIndex)
  #     %>% summarise(., switch(input$stat, 'Average' = Average = mean()))
  #     %>% ggplot(., aes())
  # )
  }
