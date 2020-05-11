class Strategies::Akatuki07
  attr_accessor :report

  PER = 1.07

  def initialize(report: nil)
    return if report.nil?
    @report = report
  end

  def run
    buy
    sell
    report.settle
    report.save
  end

  # 月初のタイミングで、現金めいいっぱいまで、ランダムに銘柄を選んで買う
  def buy
    loop do
      target_mticker = Months::TfStock.where(month: report.month).by_open_under(report.unit_cash).sample
      break if target_mticker.nil?

      report.buy(target_mticker, target_mticker.open)
      puts "buy  target_ticker: #{target_mticker.ticker.id}, price: #{target_mticker.open}, cash: #{report.cash}, tickers: #{report.report_tickers.map(&:ticker).map(&:id)}"
    end

  end

  # 5%上昇の指値で売る
  def sell
    report.report_tickers.each{ |rt|
      target_mticker = Months::TfStock.find_by(ticker: rt.ticker, month: report.month)
      next if target_mticker.nil?
      if rt.price * PER < target_mticker.high
        report.sell(target_mticker, rt.price * PER)
        puts "sell target_ticker: #{target_mticker.ticker.id}, price: #{target_mticker.open}, cash: #{report.cash}, tickers: #{report.report_tickers.map(&:ticker).map(&:id)}"
      end
    }
  end

end

