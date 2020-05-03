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

  validates :symbol, uniqueness: true

  def symbol_with_region(region = 'TOK')
    "#{symbol}.#{region}"
  end

  # ["ETF・ETN", "JASDAQ(グロース・内国株）", "JASDAQ(スタンダード・内国株）", "JASDAQ(スタンダード・外国株）", "PRO Market", "REIT・ベンチャーファンド・カントリーファンド・インフラファンド", "マザーズ（内国株）", "マザーズ（外国株）", "出資証券", "市場第一部（内国株）", "市場第一部（外国株）", "市場第二部（内国株）", "市場第二部（外国株）"]

  module CSV
    SYMBOL = 'コード'
    NAME_JA = '銘柄名'
    MARKET = '市場・商品区分'
    FIELD33 = '33業種コード'
    FIELD17 ='17業種コード'
    SCALE = '規模コード'
  end

  module ALPHA
    META_DATA = 'Meta Data'
    WEEKLY_TIME_SERIES = 'Weekly Time Series'

    module META
      INFO = '1. Information'
      SYMBOL = '2. Symbol'
      REFRESHED = '3. Last Refreshed'
      TIME_ZONE = '4. Time Zone'
    end

    module WEEKLY
      OPEN = "1. open"
      HIGH = "2. high"
      LOW = "3. low"
      CLOSE = "4. close"
      VOLUME = "5. volume"
    end
  end

end
