# == Schema Information
#
# Table name: months_tf_stocks
#
#  id         :bigint           not null, primary key
#  close      :integer
#  high       :integer
#  low        :integer
#  open       :integer
#  volume     :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  month_id   :bigint
#  ticker_id  :bigint
#
# Indexes
#
#  index_months_tf_stocks_on_month_id   (month_id)
#  index_months_tf_stocks_on_ticker_id  (ticker_id)
#
class Months::TfStock < ApplicationRecord
  self.table_name = 'months_tf_stocks'

  belongs_to :month
  belongs_to :ticker

  scope :by_open_under, -> (cash) {
    where("open <= ?", cash)
  }

  # ある月の前月からnヶ月で、高値更新したものを探す
  # instant_performance{ Months::TfStock.high_price_update_in(this_month, 12) }
  # => 0.283571904
  # new = Months::TfStock.high_price_update_in(this_month, 12)
  scope :high_price_update_in, -> (this_month, n) {
    between_months = Month.between_at(this_month.last.at.ago(n.month), this_month.last.at)

    last_highs = {}
    where(month: between_months.map(&:id)).group(:ticker_id).select('max(high) as high, ticker_id').each{ |lh|
      last_highs[lh.ticker_id]=lh.high
    }

    targets = where(month: this_month.last).select{ |last_tf|
                last_tf.high >= last_highs[last_tf.ticker_id]
              }

    where(ticker_id: targets.map(&:ticker_id)).where(month: this_month)
  }


  scope :between, -> (month, n) {
    joins(:month).merge(Month.between_at(month.at.ago(n.month), month.at))
  }

  # 過去nヶ月間での高値
  def last_high(n)
    Months::TfStock.between(month, n).where(ticker: ticker).map(&:high).max
  end

  def last
    Months::TfStock.find_by(ticker: ticker, month: month.last)
  end

end
