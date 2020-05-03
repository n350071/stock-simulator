namespace :ticker do
  desc 'ticker情報'

  # bin/rails ticker:import_tickers
  task import_tickers: :environment do
    Tickers::ImportTickersService.run
  end

  # bin/rails ticker:import_weekly_history
  task import_weekly_history: :environment do
    Tickers::ImportWeeklyHistoryService.run
  end

end

# https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=8508.TOK&apikey=T0WZY9EXEE0YAZT1
# {
#   "Meta Data": {
#       "1. Information": "Weekly Prices (open, high, low, close) and Volumes",
#       "2. Symbol": "8473.TOK",
#       "3. Last Refreshed": "2020-04-28",
#       "4. Time Zone": "US/Eastern"
#   },
#   "Weekly Time Series": {
#       "2020-04-28": {
#           "1. open": "1804.0000",
#           "2. high": "1919.0000",
#           "3. low": "1785.0000",
#           "4. close": "1897.0000",
#           "5. volume": "4914000"
#       },
#       "2020-04-24": {
#           "1. open": "1748.0000",
#           "2. high": "1804.0000",
#           "3. low": "1707.0000",
#           "4. close": "1775.0000",
#           "5. volume": "6518800"
#       },
#       "2020-04-17": {
#           "1. open": "1763.0000",
#           "2. high": "1801.0000",
#           "3. low": "1683.0000",
#           "4. close": "1752.0000",
#           "5. volume": "7254000"
#       }
#   }
# }
