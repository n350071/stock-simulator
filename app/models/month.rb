# == Schema Information
#
# Table name: months
#
#  id         :bigint           not null, primary key
#  month_at   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Month < ApplicationRecord
  has_many :tfstocks, class_name: 'Months::TfStock'

  def at_to_s
    month_at.to_s
  end
end
