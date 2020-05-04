# == Schema Information
#
# Table name: tickers
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  field17      :integer
#  field33      :integer
#  market       :integer
#  name         :string(255)
#  reflashed_at :datetime
#  scale        :integer
#  symbol       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tickers_on_deleted_at  (deleted_at)
#
class Ticker < ApplicationRecord
  acts_as_paranoid
  has_many :tfstocks, class_name: 'Months::TfStock'
  validates :symbol, uniqueness: true

  # Ticker.market_TokyoFirst => []
  # market_TokyoFirst! => update
  # market_TokyoFirst? => true/false
  enum market: [:TokyoFirst, :TokyoSecond, :Mother, :JASDAQ, :ETFN], _prefix: true
  module Market
    TokyoFirst = '市場第一部'
    TokyoSecond = '市場第二部'
    Mother = 'マザーズ'
    JASDAQ = 'JASDAQ'
    ETFN = 'ETF・ETN'
  end

  def symbol_with_region(region = 'TOK')
    "#{symbol}.#{region}"
  end

end
