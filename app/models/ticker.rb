# == Schema Information
#
# Table name: tickers
#
#  id                :bigint           not null, primary key
#  field17           :integer
#  field33           :integer
#  last_reflashed_at :datetime
#  market            :string(255)
#  name              :string(255)
#  name_ja           :string(255)
#  on_alph           :boolean
#  scale             :integer
#  symbol            :string(255)
#  time_span         :string(255)
#  time_zone         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Ticker < ApplicationRecord
  has_many :ticker_week_histories
end
