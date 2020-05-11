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

  scope :by_year_month, -> (y, m) {
    find_by(month_at: Time.zone.local(y, m)..Time.zone.local(y, m).end_of_month)
  }

  scope :by_ym, -> (y, m) {
    where(month_at: Time.zone.local(y, m)..Time.zone.local(y, m).end_of_month)
  }


  scope :between, -> (start_month, end_month) {
    where(month_at: start_month.at..end_month.at).order(:month_at)
  }

  scope :last_month,->(this_month) {
    find_by(month_at: this_month.at.last_month.beginning_of_month..this_month.at.last_month.end_of_month)
  }

  def at
    month_at
  end

  def at_to_s
    month_at.to_s
  end
end
