suppressWarnings(library(shiny))
suppressWarnings(library(markdown))
shinyUI(navbarPage("Capstone project",
                   tabPanel("Predictng the next words",

                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Enter a partial sentence to predict the next one"),
                                textInput("inputString", "Enter the partial sentence below",value = ""),
                                br(),
                                br(),
                                br(),
                                br()
                              ),
                              mainPanel(
                                h2("Predicted Next Word"),
                                verbatimTextOutput("prediction"),
                                strong("Sentence Input:"),
                                tags$style(type='text/css'), 
                                textOutput('text1'),
                                br(),
                                strong("Note:"),
                                tags$style(type='text/css'),
                                textOutput('text2')
                              )
                            )
                            
                   )
)
)