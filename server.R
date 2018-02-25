



#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  mtcars$mgsp<-ifelse(mtcars$mpg-20>0,mtcars$mpg-20,0)
  model1<-lm(hp~mpg,data=mtcars)
  model2<-lm(hp~mgsp+mpg,data=mtcars)
  
  model1pred<-reactive({
    mginput<-input$sliderMPG
    predict(model1,newdata=data.frame(mpg=mginput))
  })
  
  
  model2pred<-reactive({
    mginput<-input$sliderMPG
    predict(model2,newdata=data.frame(mpg=mginput,mgsp = ifelse(mginput-20>0,mginput-20,0)))
  })
  
  output$plot1<-renderPlot({
    
    mginput<-input$sliderMPG
    plot(mtcars$mpg,mtcars$hp,xlab='Miles per gallon',ylab="Horsepower",bty="n",pch=16,xlim=c(10,35),ylim=c(50,350))
    
    if(input$showmodel1){
      abline(model1,col="red",lwd=2)
    }
    
    
    if(input$showmodel2){
      model2lines<-predict(model2,newdata=data.frame(mpg=10:35,mgsp=ifelse(10:35-20>0,10:35-20,0)))
      lines(10:35,model2lines,col="blue",lwd=2)
    }
    
    legend(25,250,c("Model 1 prediction", "Model 2 prediction"),pch=16,col=c("red","blue"),bty="n",cex=1.2)
    
   # points(mginput,model1pred(),col="red",pch=16,cex=2)
  #  points(mginput,model2pred(),col="blue",pch=16,cex=2)
    
    
  })
  
  
  
  output$pred1<-renderText({
    model1pred()
  })
  
  output$pred2<-renderText({
    model2pred()
  })
  
  
})
