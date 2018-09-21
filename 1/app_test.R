library(shiny) 
library(lubridate)
library(ggplot2)
library(scales)
library(dplyr) 

datasetforCS112 <- read_excel("datasetforCS112.xlsx", col_types = c("numeric", "text", "text", "date", "date", "date", "date", "numeric", "numeric", "numeric", "numeric"))
test <- data.frame(datasetforCS112)




ui <- fluidPage(
  # Application title
  titlePanel("Number of projects with completion date = their revised completion date per year"),
  
  
  
  mainPanel(
    plotOutput("barPlot")
  )
  
  )


server <- function(input, output) {
  
  output$barplot <- renderPlot({
    ggplot(as.data.frame(test$projectBudget), aes(x = projectBudget )) + 
      geom_histogram()+ labs(x = "Project Budget") + 
      labs(title="Count based on groups of project budgets")
    })
  
  
}
shinyApp (ui = ui, server = server)

