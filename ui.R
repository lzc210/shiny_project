library(shiny)
starcraft = starcraft[starcraft$TotalHours < 1000000,]
names(starcraft)
league_index = sort(unique(starcraft$LeagueIndex))
names(league_index) = c('Bronze','Silver','Gold', 'Diamond','Master','GrandMaster','Professional leauges')
fluidPage(
titlePanel(
  fluidRow(
    column(4, 'Starcraft 2 Mechanics versus Strategy'),
    column(8, img(height = 300, width = 700, src = 'starcraft.jpg'))
  )
  ),
sidebarLayout(
  sidebarPanel(
    sliderInput(inputId = 'macro', label = h3('Workers Made'),
                min = 0, max = max(starcraft$WorkersMade * starcraft$MaxTimeStamp, na.rm = T),
                value = c(0, max(starcraft$WorkersMade * starcraft$MaxTimeStamp, na.rm = T))),
    sliderInput(inputId = 'hour', label = h3('Total Hours Played'),
                min = 0, max = max(starcraft$TotalHours, na.rm = T),
                value = c(0, max(starcraft$TotalHours, na.rm = T)))
    # radioButtons(inputId = 'level', label = h3('Filter by Leauge'), choices = list('All' = 1,
    #                                           'Higher Leauge' = 2, 'Lower Leauge' = 3)),
    # selectizeInput(inputId = 'group', label = h3('Group by'), c(Choose = '', c('Age','League'))),
    # radioButtons(inputId = 'stat', label = h3('Stat'), choices = list('Average' = 1, 'Standard Deviation' = 2,
    #                   'Max' = 3, 'Min' = 4))
    ),
  mainPanel(plotOutput('mechanics'),
            plotOutput('apm'),
            plotOutput('strat'))
)
)
