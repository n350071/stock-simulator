namespace :ticker do
  desc 'ticker情報'

  # bin/rails ticker:import_tickers
  task import_tickers: :environment do
    Tickers::ImportTickersService.run
  end

  # bin/rails ticker:import_monthly_history
  task import_monthly_history: :environment do
    Tickers::ImportMonthlyHistoryService.run
  end

end

