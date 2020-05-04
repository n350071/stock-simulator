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
require 'test_helper'

class Months::TfStockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
