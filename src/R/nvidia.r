# Get the data from internet
require('RMySQL')
require('quantmod')

# set timezone
Sys.setenv(TZ = "GMT")


#Get db object
#con <- dbConnect(MySQL(), user="stockuser", password="stockpwd", dbname="stockdb", host="localhost")
#sql <- "select symbol from nasdaq where industry='Semiconductors' "
#rs <- dbSendQuery(con, sql)
#tickers <- fetch(rs)

#Close database
#huh <- dbHasCompleted(rs)
#dbClearResult(rs)
#dbDisconnect(con)



getSymbols("BAC", src='yahoo', to=Sys.Date())
spy.quote = getQuote("BAC", what = yahooQuote.EOD)

# convert to xts
xts.quote <- xts(spy.quote[, -1], as.Date(spy.quote[, 1])) # use Date for indexClass
xts.quote$Adjusted <- xts.quote[, 'Close'] # add an Adjusted column

tail(rbind(BAC, xts.quote), 3)




#for(i in 1:length(tickers[,1])) {
#  ticker=tickers[i,1]

plotData <- function(name){
ticker <- name

#Get date
  beginDate <- '1990-01-01'


data <- getSymbols(ticker, from=beginDate, to=Sys.Date(), auto.assign=FALSE)

# add last day close price
data.quote = getQuote(ticker, what = yahooQuote.EOD)
xts.quote <- xts(data.quote[, -1], as.Date(data.quote[, 1])) # use Date for indexClass
xts.quote$Adjusted <- xts.quote[, 'Close'] # add an Adjusted column
data <- rbind(data, xts.quote)
#tail(data)

data <- adjustOHLC(data, use.Adjusted=TRUE) # adjust the data
dataMACD <- MACD(data)
dataHist <- dataMACD$macd - dataMACD$signal # get macd histogram
#dataMaVo <- cbind(Cl(data), dataHist, Vo(data)) # combine the macd hist with volume and close price
dataMaVo <- cbind(dataHist, Vo(data)) # combine the macd hist with volume and close price 
#filename <- c("cache/",tickers[1,1],".rdata") 
#save(data,file=filename)
#chartSeries(dataMaVo, name=ticker, subset="last 7 months", TA="addMACD()")
#chartSeries(data,name=ticker, subset='last 6 months', TA="addMACD();addBBands()")
#chartSeries(data,name=ticker, subset='last 6 months', TA="addMACD()")
chartSeries(data,name=ticker, subset='last 7 months', TA='addBBands();addVo();addMACD();addVolatility()')



#addTA(MACD(data))
#saveChart('pdf') # save the file in format of PDF


#} # for loop end

}

# 1 1 2 3 5 8 13 21 34 55 89 144



