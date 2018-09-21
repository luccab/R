#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)
library(readxl)

# Importing dataset
datasetforCS112 <- read_excel("datasetforCS112.xlsx", col_types = c("numeric", "text", "text", "date", "date", "date", "date", "numeric", "numeric", "numeric", "numeric"))
test <- data.frame(datasetforCS112)
# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Number of projects approved each year"),
  
  #sidebarPanel(
  
  # In case you want to let the graph interactive,
  # you can create a side bar + allows users input
  # and then on server.R you make a reactive variable
  # when you call the graph, so it keeps updating itself
  
  # dateRangeInput("daterange", "Choice the date",
  #                start = min(dataset$approval.date),
  #                end = max(dataset$approval.date),
  #                min = min(dataset$approval.date),
  #                max = max(dataset$approval.date),
  #                separator = " - ", format = "dd/mm/yy",
  #                startview = 'Week', language = 'us', weekstart = 1)
  
  #),
  
  mainPanel(
    # calling the output 'barplot' on server.R
    plotOutput('barplot')
  )
)
   
server <- function(input, output) {
  
  # Creating an input that let users control the variables
  # It is reactive so you need to call it on the plot of the graph
  # so it becomes reactive and any change on input will change
  # the graph V
  # dateRangeInput<-reactive({
  #   test <- subset(dataset, dataset$approval.date >= as.Date(input$daterange[1]) & dataset$approval.date <= as.Date(input$daterange[2]))
  # })
  
  output$barplot <- renderPlot({
    #dateRangeInput() <calling the reactive part
    # V output that let the graph interactive
    #output$barplot <- renderDataTable(dateRangeInput())
    
    # V plotted at: https://luccabertoncini.shinyapps.io/test/
    #barplot(table(as.numeric(format(test$approval.date, "%Y"))))
    
    # V plotted at: https://luccabertoncini.shinyapps.io/test1/
    ggplot(as.data.frame(test$project.budget), aes(x = test$project.budget )) +
      geom_histogram()+ labs(x = "Project Budget") +
      labs(title="Count based on groups of project budgets")
    
  }, height=700)
}

# Run the application 
shinyApp(ui = ui, server = server)

