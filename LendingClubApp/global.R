library(Hmisc)

# We load the data here because we want to use the factor labels and continuous value ranges 
# when we set up the UI in ui.R

# Prepare data

load("data/loansData.rda")

# only consider complete cases

loansData = loansData[complete.cases(loansData),]

# FICO is a credit score used in the data set.
# Do some data munging so we can represent it as a factor with five levels.

loansData$FICO.min <- as.numeric(gsub("-(.*)", "", as.character(loansData$FICO.Range)))
loansData$FICO.max <- as.numeric(gsub("(.*)-", "", as.character(loansData$FICO.Range)))
loansData$FICO.mid <- (loansData$FICO.max - loansData$FICO.min) / 2 + loansData$FICO.min
loansData$interest  <- as.numeric(gsub("%","",as.character(loansData$Interest.Rate)))

loansData$FICO.cut = cut2(loansData$FICO.mid, g=5)

# drop any empty factor levels to keep the user interface clear

loansData <- droplevels(loansData)

