library(shiny)
library(plotly)

ui <- fluidPage(
        
        headerPanel("Deaths in Finland - years 1980-2017"),
        sidebarPanel(
                sliderInput("year", "Select the years you want to inspect", 1980, 2017, value = c(1980, 2017), sep = ""),
                checkboxInput("total", "Show total", value = TRUE),
                checkboxInput("male", "Show male", value = TRUE),
                checkboxInput("female", "Show female", value = TRUE)
        ),
        mainPanel(
                plotlyOutput("plot1"),
                textOutput("source")
        )
)