#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting Horsepower of a car from MPG"),
  h2("Chirag Soni, 25 Feb 2018"),
  
  sidebarLayout(
    sidebarPanel(
      
      
      sliderInput("sliderMPG",
                  "MPG of car",10,35,value=20),
      checkboxInput("showmodel1","Show/hide model 1",value = TRUE),
      checkboxInput("showmodel2","Show/hide model 2",value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted HP from model 1"),
      textOutput("pred1"),
      h3("Predicted HP from model 2"),
      textOutput("pred2")
      
    )
  )
))
