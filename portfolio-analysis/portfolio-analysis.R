#Librairies
installer_packet <- function (nom, quiet=TRUE) {
  if (!requireNamespace(nom, quietly = quiet)) {
    install.packages(nom)
  }
}
packets <- c("dplyr", "quantmod", "PerformanceAnalytics", "imputeTS", "PortfolioAnalytics")
for (p in packets) {
  installer_packet(p)
}

library(dplyr)
library(quantmod)
library(PerformanceAnalytics)
library(imputeTS)
library(PortfolioAnalytics)

tickers <- c("AAPL", "AAPL", "AMZN", "NFLX")
weights <- c(.25, .25, .25, .25)

#Collection des données
portfolioPrices <- NULL
for (Ticker in tickers)
  portfolioPrices <- cbind(portfolioPrices,
                           getSymbols.yahoo(Ticker, from="2016-01-01", periodicity = "daily", auto.assign=FALSE)[,4])

benchmarkPrices <- getSymbols.yahoo("SPY", from="2016-01-01", periodicity = "daily", auto.assign=FALSE)[,4]
colSums(is.na(benchmarkPrices))
benchmarkReturns <- na.omit(ROC(benchmarkPrices, type="discrete"))


#Changement de colonnes
colnames(portfolioPrices) <- tickers

colSums(is.na(portfolioPrices))

#Affichage des prix
plot(portfolioPrices, legend = tickers)


#Calcul des retours de DF
dailyReturns <- na.omit(ROC(portfolioPrices, type="discrete"))

#Calcul des retours du portfolio
portfolioReturn <- Return.portfolio(dailyReturns, weights=weights)

#Affichage des performances
chart.CumReturns(portfolioReturn)
charts.PerformanceSummary(portfolioReturn)

#Calcule des meétriques
CAPM.beta(portfolioReturn, benchmarkReturns, .035/252)
CAPM.beta.bull(portfolioReturn, benchmarkReturns, .035/252)
CAPM.beta.bear(portfolioReturn, benchmarkReturns, .035/252)

#CAPM.alpha(portfolioReturn, benchmarkReturns, .035/252)
CAPM.jensenAlpha(portfolioReturn, benchmarkReturns, .035/252)

SharpeRatio(portfolioReturn, Rf = .035/252, p = 0.95, FUN = "StdDev",
            weights = NULL, annualize = FALSE)

table.AnnualizedReturns(portfolioReturn, Rf=.035/252, geometric=TRUE)


