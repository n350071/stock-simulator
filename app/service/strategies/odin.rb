# 市場の総評価額を計算する
class Strategies::Odin
  attr_accessor :report, :top_x

  def initialize(report: nil, strategy_params: nil)
    return if report.nil?
    @report = report
    set_params(strategy_params)
  end

  def run
    sell_all_as_destroy
    report.update(cash: 0) unless report.cash == 0
    buy
    report.settle
    report.save
  end

  # すべての銘柄を0円で買う
  def buy
    Months::TfStock.where(month: report.month).find_each{|tf|
      report.buy(tf, 0)
      puts "buy  target_ticker: #{tf.ticker.id}, price: #{0}, cash: #{report.cash}"
    }
  end

  # すべての銘柄を捨てる
  def sell_all_as_destroy
    report.report_tickers.destroy_all
  end

  def set_params(strategy_params)
    params = eval(strategy_params)
    @top_x = params[:top_x]
  end

end

