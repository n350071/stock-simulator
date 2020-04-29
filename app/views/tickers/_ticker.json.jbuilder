json.extract! ticker, :id, :name, :symbol, :time_span, :last_reflashed_at, :time_zone, :created_at, :updated_at
json.url ticker_url(ticker, format: :json)
