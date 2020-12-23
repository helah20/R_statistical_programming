# install.packages("semantic.dashboard")
# library(semantic.dashboard) to use theme on dashboard 
library(shinydashboard)
library(shiny)
# install.packages("DT")
library(DT)
ui <- dashboardPage( skin="blue",
                     dashboardHeader(title = "Cars dashboard"),
                     
                     dashboardSidebar(
                       sidebarMenu(
                         menuItem("mtcars", tabName = "mtcars", icon = icon("car")),
                         menuItem("Cars", tabName = "cars", icon = icon("car"))
                         
                       )
                     ),
                     ## Body content
                     dashboardBody( 
                       tabItems(
                 
                         tabItem("mtcars",
                                 box(plotOutput("information"),width = 8),
                                 box(
                                   selectInput("features", "Features:",
                                               c("cyl","hwy","wt")),width = 4
                                 
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
 
  output$information<- renderPlot({
    plot(mtcars$disp,mtcars[[input$features]],
         xlab = "Displeasment", ylab = "Features")
  })
  output$carstable<- renderDataTable(mtcars)
}

shinyApp(ui, server)
