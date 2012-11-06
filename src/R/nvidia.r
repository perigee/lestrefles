# Get the data from internet
require('RMySQL')
require('quantmod')

#Get db object
#con <- dbConnect(MySQL(), user="stockuser", password="stockpwd", dbname="stockdb", host="localhost")
#sql <- "select symbol from nasdaq where industry='Semiconductors' "
#rs <- dbSendQuery(con, sql)
#tickers <- fetch(rs)

#Close database
#huh <- dbHasCompleted(rs)
#dbClearResult(rs)
#dbDisconnect(con)


#for(i in 1:length(tickers[,1])) {
#  ticker=tickers[i,1]
ticker <- "FCEL"

#Get date
  beginDate <- '1990-01-01'
  today <- Sys.Date()
  format(today, format="%Y-%m-%d")


data <- getSymbols(ticker, from=beginDate, to=today, auto.assign=FALSE)
data <- adjustOHLC(data, use.Adjusted=TRUE) # adjust the data 
dataHist <- MACD(data)$macd - MACD(data)$signal # get macd histogram
dataMaVo <- cbind(dataHist, Vo(data)) # combine the macd hist with volume 
#filename <- c("cache/",tickers[1,1],".rdata")
#save(data,file=filename)
chartSeries(dataMaVo, name=ticker, subset="last 7 months")
#chartSeries(data,name=ticker, subset='last 6 months', TA="addMACD();addBBands()")
#saveChart('pdf')


#} # for loop end


# 1 1 2 3 5 8 13 21 34 55 89 144



