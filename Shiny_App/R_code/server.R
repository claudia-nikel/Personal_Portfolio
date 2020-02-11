server <-
  function(input,output){ 
    source("airports.R")
    output$main_plot <- renderPlot({
      plotTitle <- ("Where are the flights and where are they cancelled?")
      par(mar=c(1, 1, 3, 1))
      cutoff <- input$cutoff
      plot(latitude_deg ~ longitude_deg, data=subset(airports, NArrivals>cutoff), cex=sqrt(NArrivals)/100, ylim=c(21, 50), xlim=c(-125, -65), axes=FALSE, xlab="", ylab="", col="grey")
      title("Where are the flights and where are they cancelled?") 
      text(latitude_deg ~ longitude_deg, label=iata_code,
           data = subset(airports, NArrivals>cutoff),ylim=c(21, 50), xlim=c(-125, -65), cex=sqrt(Cancelled)/70, adj=1)
      legend("bottomleft", legend=c("size: No. Flights"), pch=c(1)) 
      legend("bottomright", legend=c("Code size: No. Cancellations"))
    })
  }