library(shiny)
library(fpp3)
library(markdown)
library(shinythemes)

Data_Science1 <- read.csv('GT_Data_Science.csv')
Data_Science1$Week <- mdy(Data_Science1$Week)
Data_Science <- Data_Science1
Data_Science$Week <- yearweek(Data_Science$Week)
Data_Science <- tsibble(Data_Science)

Business_Analyst1 <- read.csv('GT_Business_Analyst.csv')
Business_Analyst1$Month <- ym(Business_Analyst1$Month)
Business_Analyst <- Business_Analyst1
Business_Analyst$Month <- yearmonth(Business_Analyst$Month)
Business_Analyst <- tsibble(Business_Analyst)

fit_m <- Data_Science %>%
  model(MEAN(Data.Science...United.States.))

fit_n <- Data_Science %>%
  model(NAIVE(Data.Science...United.States.))

fit_sn <- Data_Science %>%
  model(SNAIVE(Data.Science...United.States.))

fit_dr <- Data_Science %>%
  model(NAIVE(Data.Science...United.States. ~ drift()))

fit_Holts <- Data_Science %>%
  model(ETS(Data.Science...United.States. ~ error("A") + trend("A") + season("N")))

fit_Holwin <- Data_Science %>%
  model(
    additive = ETS(Data.Science...United.States. ~ error("A") + trend("A") +season("A")),
    multiplicative = ETS(Data.Science...United.States. ~ error("M") + trend("A") +season("M"))
  )

fit_extra <- Data_Science %>%
  model(
    auto_ets = ETS(Data.Science...United.States.),
    manual_ets = ETS(Data.Science...United.States. ~ error("A") + trend("A") + season("A")),
    tslm = TSLM(Data.Science...United.States. ~ trend() + season())
  )

fit_ar1 <- Data_Science %>%
  model(ARIMA(Data.Science...United.States.))

fit_ar2 <- Data_Science %>%
  model(ARIMA(Data.Science...United.States. ~ pdq(0,1,2) + PDQ(1,1,0)))

ui <- navbarPage("Data Science by Connor Kerr",
                 theme = shinytheme('darkly'),
                 
                 tabPanel("Instructions for App",
                          fluidRow(
                            column(9,
                                   'About the App:'
                            ),
                            column(9,
                                   '*'
                            ),
                            column(9,
                                   '~ This App was designed to show a projection for the Data Science field!'
                            ),
                            column(9,
                                   '~ I created serveral different models projecting the popularity of Data Science based on google searches within the last year.'
                            ),
                            column(9,
                                   '*'
                            ),
                            column(9,
                                   '*'
                            ),
                            column(9,
                                   '*'
                            ),
                            column(9,
                                   'Instructions/Description of App:'
                            ),
                            column(9,
                                   '*'
                            ),
                            column(9,
                                   '~ To use this app just click on the top menu to navigate between the different time series models.'
                            ),
                            column(9,
                                   '~ Under the Plot tab you can select from several plots showing the current know data.'
                            ),
                            column(9,
                                   '~ Under the Simple Models tab you can select from several models showing simple projections for the data.'
                            ),
                            column(9,
                                   '~ Under the Exponential Smoothing tab you will see Holts/Winter/More.'
                            ),
                            column(9,
                                   '~ Under the ARIMA tab you will see both a manual and auto selected ARIMA models.'
                            )
                          )
                          
                          
                 ),
                 
                 tabPanel("Plots",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType", "Plot Types:",
                                           c("Seasonality"= 's',
                                             "Autocorrelation"= 'a',
                                             "Line Plot" = 'l')
                              )
                            ),
                            mainPanel(
                              plotOutput("plot")
                            )
                          )
                 ),
                 
                 tabPanel("Simple Models",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType2", "Simple Models:",
                                           c("Mean" = 'me',
                                             "NAIVE" = 'na',
                                             "Seasonal NAIVE" = 'sn',
                                             "Drift" = 'dr')
                              )
                            ),
                            mainPanel(
                              plotOutput("plot2")
                            )
                          )
                 ),
                 
                 tabPanel("Exponential Smoothing",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType3", "Listed Options:",
                                           c("Holts" = 'Holts',
                                             "Holts/Winters" = 'Holwin',
                                             "More" = 'Ext'
                                           )
                              )
                            ),
                            mainPanel(
                              plotOutput("plot3")
                            )
                          )
                 ),
                 
                 tabPanel("ARIMA",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("plotType4", "Listed Options:",
                                           c("Auto-selected Parameters" = 'arima_auto',
                                             "Manually Selected Parameters" = 'arima_man'
                                           )
                              )
                            ),
                            mainPanel(
                              plotOutput("plot4")
                            )
                          )
                 ),
)

server <- function(input, output, session) {
  
  Data_Science1 <- read.csv('GT_Data_Science.csv')
  Data_Science1$Week <- mdy(Data_Science1$Week)
  Data_Science <- Data_Science1
  Data_Science$Week <- yearweek(Data_Science$Week)
  Data_Science <- tsibble(Data_Science)
  
  Business_Analyst1 <- read.csv('GT_Business_Analyst.csv')
  Business_Analyst1$Month <- ym(Business_Analyst1$Month)
  Business_Analyst <- Business_Analyst1
  Business_Analyst$Month <- yearmonth(Business_Analyst$Month)
  Business_Analyst <- tsibble(Business_Analyst)
  
  fit_m <- Data_Science %>%
    model(MEAN(Data.Science...United.States.))
  
  fit_n <- Data_Science %>%
    model(NAIVE(Data.Science...United.States.))
  
  fit_sn <- Data_Science %>%
    model(SNAIVE(Data.Science...United.States.))
  
  fit_dr <- Data_Science %>%
    model(NAIVE(Data.Science...United.States. ~ drift()))
  
  fit_Holts <- Data_Science %>%
    model(ETS(Data.Science...United.States. ~ error("A") + trend("A") + season("N")))
  
  fit_Holwin <- Data_Science %>%
    model(
      additive = ETS(Data.Science...United.States. ~ error("A") + trend("A") +season("A")),
      multiplicative = ETS(Data.Science...United.States. ~ error("M") + trend("A") +season("M"))
    )
  
  fit_extra <- Data_Science %>%
    model(
      auto_ets = ETS(Data.Science...United.States.),
      manual_ets = ETS(Data.Science...United.States. ~ error("A") + trend("A") + season("A")),
      tslm = TSLM(Data.Science...United.States. ~ trend() + season())
    )
  
  fit_ar1 <- Data_Science %>%
    model(ARIMA(Data.Science...United.States.))
  
  fit_ar2 <- Data_Science %>%
    model(ARIMA(Data.Science...United.States. ~ pdq(0,1,2) + PDQ(1,1,0)))
  
  output$plot <- renderPlot({
    switch(
      input$plotType,
      s = gg_season(Data_Science),
      a = autoplot(ACF(Data_Science)),
      l = plot(Data_Science, type=input$plotType)
    )
  })
  
  output$plot2 <- renderPlot({
    switch(
      input$plotType2,
      me = fit_m %>%
        forecast(h = 10) %>%
        autoplot(Data_Science),
      na = fit_n %>%
        forecast(h = 10) %>%
        autoplot(Data_Science),
      sn = fit_sn %>%
        forecast(h = 10) %>%
        autoplot(Data_Science),
      dr = fit_dr %>%
        forecast(h = 10) %>%
        autoplot(Data_Science)
    )
  })
  
  output$plot3 <- renderPlot({
    switch(
      input$plotType3,
      Holts = fit_Holts %>%
        forecast(h = '5 years') %>%
        autoplot(Data_Science),
      Holwin = fit_Holwin %>%
        forecast(h = '5 years') %>%
        autoplot(Data_Science),
      Ext = fit_extra %>%
        forecast(h = '5 years') %>%
        autoplot(Data_Science)
    )
  })
  
  output$plot4 <- renderPlot({
    switch(
      input$plotType4,
      arima_auto = fit_ar1 %>%
        forecast(h = '1 year') %>%
        autoplot(Data_Science),
      arima_man = fit_ar2 %>%
        forecast(h = '1 year') %>%
        autoplot(Data_Science)
    )
  })

}

shinyApp(ui = ui, server = server)
