class Tickers::ImportTickersService
  # 東証のCSVからTicker情報を収取する
  # https://www.jpx.co.jp/markets/statistics-equities/misc/01.html
  # 東証上場銘柄一覧（２０２０年３月末）

  def self.run
    new.run
  end

  def initialize

  end

  def run
    path = Rails.root.join('tmp','ticker','jpx_2020_03.csv')
    return unless File.exist?(path)

    puts 'Ticker Import Start'
    require 'csv'
    CSV.foreach(path, headers: true) do |row|
      next if Ticker.find_by(symbol: row[Ticker::CSV.symbol])

      ticker = Ticker.create(
        symbol: row[Ticker::CSV::SYMBOL],
        name_ja: row[Ticker::CSV::NAME_JA],
        market: row[Ticker::CSV::MARKET],
        field33: row[Ticker::CSV::FIELD33],
        field17: row[Ticker::CSV::FIELD17],
        scale: row[Ticker::CSV::SCALE],
      )
      puts "#{ticker.name_ja}: #{ticker.symbol}" if ticker.persisted?
    end
    puts 'Ticker Import End'
  end
end

