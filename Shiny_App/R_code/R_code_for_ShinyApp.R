library(shiny)
source("airports.R")
source("cancellations.R")

server <-function(input,output){ 
  source("airports.R")
  source("cancellations.R")
  output$delayed<- renderPlot({
    cutoff<-input$cutoff
    par(mar=c(1, 1, 3, 1))
    plot(latitude_deg ~ longitude_deg, data = subset(airports,NArrivals>10000), cex=sqrt(NArrivals)/100,ylim=c(21, 50), xlim=c(-125, -65), axes=FALSE, xlab="", ylab="",col="grey")
    title("Connections with the most delayed flights")
    legend("bottomleft", legend=c("size: No. Flights"), pch=c(1))
    legend("bottomright", legend=c("Code size: No. Cancelled Flights")) 
    with(subset(cancellations, (DepDelay+ArrDelay)>cutoff), segments(longOrigin, latOrigin, longDest, latDest, col="blue", lwd=sqrt(DepDelay+ArrDelay)/30))
    text(latitude_deg ~ longitude_deg, label=iata_code, data = subset(airports, NArrivals>10000), ylim=c(21, 50), xlim=c(-125, -65), cex=sqrt(Cancelled)/70)
    
  })
  
  output$cancelled<- renderPlot({
    cutoff<-input$cutoff
    par(mar=c(1, 1, 3, 1))
    plot(latitude_deg ~ longitude_deg, data = subset(airports,NArrivals>10000), cex=sqrt(NArrivals)/100,ylim=c(21, 50), xlim=c(-125, -65), axes=FALSE, xlab="", ylab="",col="grey")
    title("Connections with the most cancelled flights")
    legend("bottomleft", legend=c("size: No. Flights"), pch=c(1))
    legend("bottomright", legend=c("Code size: No. Cancelled Flights")) 
    with(subset(cancellations, Cancelled>cutoff), segments(longOrigin, latOrigin, longDest, latDest, col="red", lwd=Cancelled/500))
    text(latitude_deg ~ longitude_deg, label=iata_code, data = subset(airports, NArrivals>10000), ylim=c(21, 50), xlim=c(-125, -65), cex=sqrt(Cancelled)/70)   
    
  })   
  
}

ui <- shinyUI(pageWithSidebar(
  headerPanel("What airports and flight connections to avoid?"),
  sidebarPanel(
    sliderInput("cutoff", "Cutoff parameter:", min=0, max=750, value=250),
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Delayed", plotOutput("delayed")), 
      tabPanel("Cancelled", plotOutput("cancelled"))
      
    )
  )
))
shinyApp(ui=ui, server=server)