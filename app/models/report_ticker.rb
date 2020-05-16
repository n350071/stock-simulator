# == Schema Information
#
# Table name: report_tickers
#
#  id         :bigint           not null, primary key
#  price      :bigint
#  valuation  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  month_id   :bigint
#  report_id  :bigint
#  ticker_id  :bigint
#
# Indexes
#
#  index_report_tickers_on_month_id   (month_id)
#  index_report_tickers_on_report_id  (report_id)
#  index_report_tickers_on_ticker_id  (ticker_id)
#
class ReportTicker < ApplicationRecord
  belongs_to :report
  belongs_to :ticker
  belongs_to :month # 購入月

  scope :by_ticker, -> (ticker) {
    where(ticker: ticker)
  }

  # ある月からnヶ月以上保持しているものを探す
  scope :by_keep_over, -> (this_month, n) {
    joins(:month).merge(Month.between_at(this_month.at.ago(n.month), this_month.at))
  }

  def settle(month)
    tfstock = tfstocks(month)
    self.valuation = tfstock.nil? ? 0 : tfstock.close
  end

  def rate
    valuation / price.to_f
  end

  # ある月のtfstockを見つける
  def tfstocks(that_month)
    Months::TfStock.find_by(ticker: ticker, month: that_month)
  end

  def keep_month(this_month)
    (this_month.at - month.at).round(-1)/30
  end

end
