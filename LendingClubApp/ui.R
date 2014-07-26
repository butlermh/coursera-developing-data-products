library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Lending Club Loan Interest Rate Calculator"),

    sidebarPanel(

      radioButtons("loanLength",
        label = h4("Loan Length"),
        # create the choices from the factor levels for loan length
        choices = attributes(loansData$Loan.Length)$levels,
        # initially select the most common value
        selected = names(which.max(table(loansData$Loan.Length)))),

      sliderInput("amountRequested",
        label = h4("Amount Requested ($)"),
        # create the range from the data
        min = min(loansData$Amount.Requested), 
        max = max(loansData$Amount.Requested),
        # initially select the mean value 
        value = mean(loansData$Amount.Requested)),

      selectInput("ficoScore",
        label = h4("FICO score"),
        choices = attributes(loansData$FICO.cut)$levels,
        # initially select the most common value 
        selected = names(which.max(table(loansData$FICO.cut)))) 

    ),
    mainPanel(
        helpText("The", 
          a("Lending Club", href="https://www.lendingclub.com/"), 
          "is an on-line financial community that aims to reduce the cost and complexity of lending compared to bank. It determines the loan interest rate based on characteristics of the borrower such as their employment history, credit history and credit score."),
        helpText("A credit score is a number representing the likelihood that a person will pay his or her debts. The Lending Club uses the", 
          a("FICO score.", href="http://en.wikipedia.org/wiki/FICO_score")), 
        helpText("This calculator uses", 
          a("historical data", href="https://spark-public.s3.amazonaws.com/dataanalysis/loansData.rda"), 
          a("(see associated code book)", href="https://spark-public.s3.amazonaws.com/dataanalysis/loansCodebook.pdf"), 
          "from the Lending Club to predict the interest rate a borrower will pay based on the loan length in months, the amount requested in dollars, and their FICO score."),
        helpText("See the accompanying", a("presentation", href="http://rpubs.com/butlermh/lendingclub"), "about this app for more information"),
        h3("Predicted Interest Rate"),
        verbatimTextOutput("prediction")
    )
  )
)
