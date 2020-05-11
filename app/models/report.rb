# == Schema Information
#
# Table name: reports
#
#  id                  :bigint           not null, primary key
#  cash                :bigint
#  term                :integer
#  total_asset         :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  month_id            :bigint
#  month_simulation_id :bigint
#
# Indexes
#
#  index_reports_on_month_id             (month_id)
#  index_reports_on_month_simulation_id  (month_simulation_id)
#
class Report < ApplicationRecord
  belongs_to :month_simulation
  belongs_to :month
  has_many :tickers, through: :report_tickers
  has_many :report_tickers, dependent: :destroy
  has_many :performances, dependent: :destroy

  UNIT = 100

  def run(strategy)
    @buy = @sell = 0
    "Strategies::#{strategy}".constantize.new(report: self).run
  end

  def buy(mticker, price)
    self.cash -= price * UNIT
    @buy += price
    report_tickers.build(ticker: mticker.ticker, price: price)
  end

  def sell(mticker, price)
    self.cash += price * UNIT
    @sell += price
    report_tickers.delete( report_tickers.select{|rt| rt.ticker == mticker.ticker}.first )
  end

  # 決算
  def settle
    report_tickers.each{|rt| rt.settle(month) }
    self.total_asset = self.cash + report_tickers.map(&:valuation).sum * UNIT

    performances.create(
      month: month,
      cash: cash,
      total_asset: self.total_asset,
      sum_valuation: report_tickers.map(&:valuation).sum,
      sum_price: report_tickers.map(&:price).sum,
      buy: @buy,
      sell: @sell
    )

  end

  def valuation
    settle if total_asset.nil?
    total_asset - cash
  end

  def buying_price
    report_tickers.map(&:price).sum * UNIT
  end

  def unit_cash
    cash / UNIT
  end

  # def copy_from_last_month(:month, :month_simulation)
  #   report = last_report(month: month, month_simulation: month_simulation)
  #   term = report.term + 1
  # end

  # def last_report(month)
  #   report.find_by(month: Month.last_month(month), month_simulation: self)
  # end

  def show
    puts "総資産: #{total_asset}, Cash: #{cash}, 評価額: #{valuation}, 買付価格: #{buying_price}"
    puts "内訳 [社名]: 評価額, 買付価格"
    report_tickers.each{ |rt|
      puts "#{rt.ticker.name}: #{rt.valuation}, #{rt.price} (#{rt.rate})"
    }
  end

  # private
  # def close_unit_price
  #   report_tickers.map{ |rt|
  #     Months::TfStock.find_by(ticker: rt.ticker, month: month).close
  #   }.sum * UNIT
  # end

end
