# == Schema Information
#
# Table name: report_tickers
#
#  id         :bigint           not null, primary key
#  price      :bigint
#  valuation  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  report_id  :bigint
#  ticker_id  :bigint
#
# Indexes
#
#  index_report_tickers_on_report_id  (report_id)
#  index_report_tickers_on_ticker_id  (ticker_id)
#
class ReportTicker < ApplicationRecord
  belongs_to :report
  belongs_to :ticker
# 購入月も知りたい

  def tfstocks(month)
    Months::TfStock.find_by(ticker: ticker, month: month)
  end

  def settle(month)
    tfstock = tfstocks(month)
    self.valuation = tfstock.nil? ? 0 : tfstock.close
  end

  def rate
    valuation / price.to_f
  end
end
