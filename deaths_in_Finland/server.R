library(shiny)
shinyServer(function(input, output) {
        # Get the data
        dataUrl <- "https://raw.githubusercontent.com/zavolainen/developing_data_products_project/master/kuol_002_201700.csv"
        deaths <- read.csv(dataUrl, stringsAsFactors=FALSE)
        

        
        
        output$plot1 <- renderPlot({
                mpgInput <- input$sliderMPG
                
                plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
                     ylab = "Horsepower", bty = "n", pch = 16,
                     xlim = c(10, 35), ylim = c(50, 350))
                if(input$showModel1){
                        abline(model1, col = "red", lwd = 2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
                        ))
                        lines(10:35, model2lines, col = "blue", lwd = 2)
                }
                
                legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
                       col = c("red", "blue"), bty = "n", cex = 1.2)
                points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
        })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
})