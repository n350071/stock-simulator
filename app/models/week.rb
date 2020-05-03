# == Schema Information
#
# Table name: weeks
#
#  id         :bigint           not null, primary key
#  week_at    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Week < ApplicationRecord
  has_many :ticker_week_histories

  validates :week_at, uniqueness: true

  def at_to_s
    week_at.to_s
  end

end
