# install.packages("semantic.dashboard")
# library(semantic.dashboard) to use theme on dashboard 

library(shinydashboard)
library(shiny)
# install.packages("DT")
library(DT)
 # View(iris)
 #View(cars)
ui <- dashboardPage( skin="blue",
  dashboardHeader(title = "my dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Iris", tabName = "Iris", icon = icon("tree")),
      menuItem("Cars", tabName = "cars", icon = icon("car"))
      
    )
  ),
  ## Body content
  dashboardBody( 
    tabItems(
      tabItem("iris",
              box(plotOutput("correlation_plot"),width = 8),# any thing we defind it here we must activate it in server
              box(
                selectInput("features", "Features:",
                            c("Sepal.Width", "Petal.Length",
                              "Petal.Width")),width = 4
              )
      ),
      tabItem("cars",
              fluidPage(
              h1("Cars"),
              dataTableOutput("carstable")
              )
     )
   )
 )

)
server <- function(input, output) {
  output$correlation_plot <- renderPlot({
    plot(iris$Sepal.Length, iris[[input$features]],
         xlab = "Sepal Length", ylab = "Features") 
  })
  output$carstable<- renderDataTable(mtcars)
}

shinyApp(ui, server)
