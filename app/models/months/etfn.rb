# == Schema Information
#
# Table name: etfns
#
#  id         :bigint           not null, primary key
#  close      :integer
#  high       :integer
#  integer    :bigint
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
#  index_etfns_on_month_id   (month_id)
#  index_etfns_on_ticker_id  (ticker_id)
#
class Months::Etfn < ApplicationRecord
  self.table_name = 'etfns'

  belongs_to :month
  belongs_to :ticker


end
