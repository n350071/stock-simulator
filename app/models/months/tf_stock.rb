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

  # ある月からnヶ月で、高値更新したものを探す
  scope :high_price_update_in, -> (this_month, n) {
    where(month: this_month).select{ |ti|
      ti.high >= ti.last_high(n)
    }

  }

  scope :between, -> (month, n) {
    joins(:month).merge(Month.between_at(month.at.ago(n.month), month.at))
  }

  # 過去nヶ月間での高値
  def last_high(n)
    Months::TfStock.between(month, n).where(ticker: ticker).map(&:high).max
  end

end
