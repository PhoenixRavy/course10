library(shiny)

suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

# Loading the files
#quad_gram <- readRDS("~/R/quad_gram.RData")
#tri_gram <- readRDS("~/R/tri_gram.RData")
#bi_gram <- readRDS("~/R/bi_gram.RData")
#uni_gram <- readRDS("~/R/uni_gram.RData")

quad_gram <- readRDS("quad_gram.RData")
tri_gram <- readRDS("tri_gram.RData")
bi_gram <- readRDS("bi_gram.RData")
uni_gram <- readRDS("uni_gram.RData")

#uni_gram <- read.csv("uni_gram.csv",stringsAsFactors = F)
#bi_gram <- read.csv("bi_gram.csv",stringsAsFactors = F)
#tri_gram <- read.csv("tri_gram.csv",stringsAsFactors = F)
#quad_gram <- read.csv("quad_gram.csv",stringsAsFactors = F)

mesg <<- ""

# Cleaning of user input before predicting the next word

Predict <- function(x) {
  xclean <- removeNumbers(removePunctuation(tolower(x)))
  xs <- strsplit(xclean, " ")[[1]]
  

  if (length(xs)>= 3) {
    xs <- tail(xs,3)
    if (identical(character(0),head(quad_gram[quad_gram$uni_gram == xs[1] & quad_gram$bi_gram == xs[2] & quad_gram$tri_gram == xs[3], 4],1))){
      Predict(paste(xs[2],xs[3],sep=" "))
    }
    else {mesg <<- "Next word is predicted using quad-gram."; head(quad_gram[quad_gram$uni_gram == xs[1] & quad_gram$bi_gram == xs[2] & quad_gram$tri_gram == xs[3], 4],1)}
  }
  else if (length(xs) == 2){
    xs <- tail(xs,2)
    if (identical(character(0),head(tri_gram[tri_gram$uni_gram == xs[1] & tri_gram$bi_gram == xs[2], 3],1))) {
      Predict(xs[2])
    }
    else {mesg<<- "Next word is predicted using tri-gram."; head(tri_gram[tri_gram$uni_gram == xs[1] & tri_gram$bi_gram == xs[2], 3],1)}
  }
  else if (length(xs) == 1){
    xs <- tail(xs,1)
    if (identical(character(0),head(bi_gram[bi_gram$uni_gram == xs[1], 2],1))) {mesg<<-"No match found. Most common word 'the' is returned."; head("the",1)}
    else {mesg <<- "Next word is predicted using bi-gram."; head(bi_gram[bi_gram$uni_gram == xs[1],2],1)}
  }
}


shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- Predict(input$inputString)
    output$text2 <- renderText({mesg})
    result
  });
  
  output$text1 <- renderText({
    input$inputString});
}
)