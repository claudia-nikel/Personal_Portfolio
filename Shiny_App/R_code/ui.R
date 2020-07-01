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
