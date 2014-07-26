library(shiny)
library(Hmisc)

# Build a simple linear model that predicts the interest rate from the FICO score,
# the requested loan amount and the loan length

fit <- lm(interest ~ FICO.cut + scale(log10(Amount.Requested)) + Loan.Length, data=loansData)

shinyServer(
  function(input, output) {

   # predict the interest rate using the model

    output$prediction <- renderText({
        noquote(
          paste(
            round(
              predict(fit, 
                newdata = data.frame(
                FICO.cut = factor(input$ficoScore, levels = attributes(loansData$FICO.cut)$levels), 
                Amount.Requested = input$amountRequested,
                Loan.Length = factor(input$loanLength, levels = attributes(loansData$Loan.Length)$levels)
              ))[[1]], 1), "%"))})
  }
)
