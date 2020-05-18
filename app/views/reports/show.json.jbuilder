json.id(@report.id)
json.set! :performances do
  json.array!(@report.performances) do |perf|
    json.month(perf.month.at_ym)
    json.total_asset(perf.total_asset)
    json.total_badget(perf.total_badget)
    json.cash(perf.cash)
    json.buy(perf.buy)
    json.sell(perf.sell)
    json.ticker_count(perf.ticker_count || 0)
  end
end
# json.extract! ticker_week_history, :id, :open, :high, :low, :close, :volue, :week_at, :created_at, :updated_at
# json.url ticker_week_history_url(ticker_week_history, format: :json)
# json.partial! "ticker_week_histories/ticker_week_history", ticker_week_history: @ticker_week_history
