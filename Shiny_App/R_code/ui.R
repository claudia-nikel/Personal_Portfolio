ui <- shinyUI(pageWithSidebar(
  headerPanel("Scatter Plot"),
  sidebarPanel(
    textInput("cutoff", "Enter your cutoff parameter:", "12000"),
  ),
  mainPanel(
    plotOutput(outputId='main_plot')
  )
)
)