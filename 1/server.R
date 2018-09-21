library(shiny)
library(ggplot2)

# Importing dataset
datasetforCS112 <- read_excel("datasetforCS112.xlsx", col_types = c("numeric", "text", "text", "date", "date", "date", "date", "numeric", "numeric", "numeric", "numeric"))
test <- data.frame(datasetforCS112)

function(input, output) {
  
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