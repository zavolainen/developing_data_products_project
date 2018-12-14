library(shiny)
library(plotly)
library(tibble)
library(varhandle)

server <- function(input, output) {
        
        dataUrl <- "https://raw.githubusercontent.com/zavolainen/developing_data_products_project/master/kuol_002_201700.csv"
        deaths <- t(read.csv(dataUrl, stringsAsFactors=FALSE))
        colnames(deaths) <- deaths[1,]
        deaths <- deaths[2:nrow(deaths),]
        deaths <- rownames_to_column(as.data.frame(deaths), "Year")
        deaths <- as.data.frame(lapply(deaths, gsub, pattern='X', replacement=''))
        deaths <- unfactor(deaths)

        output$source <- renderText({
                "Source: Statistics Finland"
        })
        
        output$plot1 <- renderPlotly({
                
                minYear <- input$year[1]
                maxYear <- input$year[2]
                
                deaths <- deaths[which(deaths$Year == minYear):(which(deaths$Year == maxYear)),]
                
                plot <- plot_ly(deaths, x = deaths$Year, hoverinfo = "text", 
                                text = paste("Deaths by sex <br>Year: ", deaths$Year, "<br>Total: ", deaths$Any, 
                                             "<br>Female: ", deaths$Female, "<br>Male: ", deaths$Male)) %>%
                        layout(yaxis = list(rangemode = "tozero"))
                
                if(input$total){
                        plot <- plot %>% add_trace(y = deaths$Any, name = 'Any sex',type = 'scatter', 
                                                   mode = 'lines+markers')
                } 
                if(input$female){
                        plot <- plot %>% add_trace(y = deaths$Female, name = 'Female',type = 'scatter', 
                                                   mode = 'lines+markers')
                } 
                if(input$male){
                        plot <- plot %>% add_trace(y = deaths$Male, name = 'Male',type = 'scatter', 
                                                   mode = 'lines+markers')
                }
                
                if (input$total == FALSE & input$female == FALSE & input$male == FALSE ) {
                        suppressWarnings(plotly_empty())

                } else {
                        plot
                }
        })}
        
        