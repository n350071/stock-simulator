# == Schema Information
#
# Table name: performances
#
#  id                              :bigint           not null, primary key
#  buy(今月の購入額)               :integer
#  cash                            :bigint
#  sell(今月の売却額)              :integer
#  sum_price(保有銘柄の買付額)     :integer
#  sum_valuation(保有銘柄の評価額) :integer
#  total_asset                     :bigint
#  total_buy(累積の購入額)         :integer
#  total_sell(累積の売却額)        :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  month_id                        :bigint
#  report_id                       :bigint
#
# Indexes
#
#  index_performances_on_month_id   (month_id)
#  index_performances_on_report_id  (report_id)
#
class Performance < ApplicationRecord
  belongs_to :report
  belongs_to :month

  # 保有銘柄数
  # 保有月数

end
