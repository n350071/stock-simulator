# == Schema Information
#
# Table name: ticker_week_histories
#
#  id         :bigint           not null, primary key
#  close      :integer
#  high       :integer
#  low        :integer
#  open       :integer
#  volue      :integer
#  week_at    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticker_id  :bigint
#
# Indexes
#
#  index_ticker_week_histories_on_ticker_id  (ticker_id)
#
class TickerWeekHistory < ApplicationRecord
  belongs_to :ticker
end
