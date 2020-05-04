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
      next if Ticker.find_by(symbol: row[CSV_ATTR::SYMBOL])
      next if (market = get_market(row[CSV_ATTR::MARKET])) == -1

      ticker = Ticker.create(
        symbol: row[CSV_ATTR::SYMBOL],
        name: row[CSV_ATTR::NAME_JA],
        market: market,
        field33: row[CSV_ATTR::FIELD33],
        field17: row[CSV_ATTR::FIELD17],
        scale: row[CSV_ATTR::SCALE],
      )

      puts "#{ticker.name}: #{ticker.symbol} in #{ticker.market}" if ticker.persisted?
    end
    puts 'Ticker Import End'
  end

  def get_market(market)
    case market
    when Regexp.new(Ticker::Market::TokyoFirst)
      Ticker.markets["TokyoFirst"]
    when Regexp.new(Ticker::Market::TokyoSecond)
      Ticker.markets["TokyoSecond"]
    when Regexp.new(Ticker::Market::Mother)
      Ticker.markets["Mother"]
    when Regexp.new(Ticker::Market::JASDAQ)
      Ticker.markets["JASDAQ"]
    when Regexp.new(Ticker::Market::ETFN)
      Ticker.markets["ETFN"]
    else
      -1
    end
  end

  module CSV_ATTR
    SYMBOL = 'コード'
    NAME_JA = '銘柄名'
    MARKET = '市場・商品区分'
    FIELD33 = '33業種コード'
    FIELD17 ='17業種コード'
    SCALE = '規模コード'
  end

end

