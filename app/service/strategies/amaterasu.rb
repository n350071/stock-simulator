# 新高値ロジック+保持期間に応じてリリース
class Strategies::Amaterasu
  attr_accessor :report, :up_per, :loss_per, :n_month, :r_month

  def initialize(report: nil, strategy_params: nil)
    return if report.nil?
    return if strategy_params.nil?

    @report = report
    set_params(strategy_params)
  end

  def run
    buy
    sell
    report.settle
end

  # 月初のタイミングで、現金めいいっぱいまで、ランダムに銘柄を選んで買う
  def buy
    tfstocks = Months::TfStock.high_price_update_in(report.month, n_month)
    loop do
      # 過去n_monthヶ月で、高値更新した株を優先的に、安すぎないものを買う
      target_mticker = tfstocks.select{ |tf|
        tf.open <= report.unit_cash && tf.open >= 500
      }.sample
      break if target_mticker.nil?

      report.buy(target_mticker, target_mticker.open)
      puts "buy  target_ticker: #{target_mticker.ticker.id}, price: #{target_mticker.open}, cash: #{report.cash}, tickers: #{report.report_tickers.map(&:ticker).map(&:id)}"
    end

  end

  def sell
    report.report_tickers.each{ |rt|
      target_mticker = Months::TfStock.find_by(ticker: rt.ticker, month: report.month)
      next if target_mticker.nil?

      # 先月の終値次第で損切りする
      last_mticker = Months::TfStock.find_by(ticker: rt.ticker, month: report.month.last)
      if sell_open?(last_mticker, rt, report.month)
        report.sell(target_mticker,  target_mticker.open)
        puts "losscut target_ticker: #{last_mticker.ticker.id}, price: #{last_mticker.open}, cash: #{report.cash}, tickers: #{report.report_tickers.map(&:ticker).map(&:id)}"
        next
      end

      # 利益確定
      if rt.price * up_per < target_mticker.high
        report.sell(target_mticker, rt.price * up_per)
        puts "sell target_ticker: #{target_mticker.ticker.id}, price: #{target_mticker.open}, cash: #{report.cash}, tickers: #{report.report_tickers.map(&:ticker).map(&:id)}"
        next
      end
    }
  end

  def sell_open?(last_mticker, rt, this_month)
    return true if loss_per && last_mticker && last_mticker.open * loss_per > last_mticker.close
    return true if rt.keep_month(this_month) >= r_month

    false
  end

  def set_params(strategy_params)
    params = eval(strategy_params)
    @up_per = params[:up_per]
    @loss_per = params[:loss_per]
    @n_month = params[:n_month]
    @r_month = params[:r_month]
  end
end

