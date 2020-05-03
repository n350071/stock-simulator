# == Schema Information
#
# Table name: ticker_week_histories
#
#  id         :bigint           not null, primary key
#  close      :integer
#  high       :integer
#  low        :integer
#  open       :integer
#  volume     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticker_id  :bigint
#  week_id    :bigint
#
# Indexes
#
#  index_ticker_week_histories_on_ticker_id  (ticker_id)
#  index_ticker_week_histories_on_week_id    (week_id)
#
class TickerWeekHistory < ApplicationRecord
  belongs_to :ticker
  belongs_to :week

  def week_at
    week.week_at
  end

  scope :by_week, -> (week_at_to_s) {
    week = Week.find_by(week_at: Time.zone.parse(week_at_to_s))
    where(week: week)
  }
end
