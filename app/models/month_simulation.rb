# == Schema Information
#
# Table name: month_simulations
#
#  id             :bigint           not null, primary key
#  badget         :bigint
#  strategy       :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  end_month_id   :bigint
#  start_month_id :bigint
#
# Indexes
#
#  index_month_simulations_on_end_month_id    (end_month_id)
#  index_month_simulations_on_start_month_id  (start_month_id)
#
# Foreign Keys
#
#  fk_rails_...  (end_month_id => months.id)
#  fk_rails_...  (start_month_id => months.id)
#
class MonthSimulation < ApplicationRecord
  belongs_to :start_month, class_name: 'Month'
  belongs_to :end_month, class_name: 'Month'
  has_many :reports, dependent: :destroy

  TRIALS = 10

  def run
    traials = TRIALS
    traials.times{
      run_each_simulation
    }
  end

  def run_each_simulation
    report = reports.build(cash: badget)

    Month.between(start_month, end_month).each{ |month|
      puts "#{month.at_to_s}, cash: #{report.cash}"

      report.update(month: month)
      report.run(strategy)
      report.show

      puts ""
    }
  end

  def summarize
    # 平均総資産
    asset_ave
    # 分散総資産
    asset_sigma
    # 中央総資産
    asset_mean
  end

  def asset_ave
    (reports.map(&:total_asset).sum / TRIALS).round
  end

  def asset_sigma
    samples = reports.map(&:total_asset)
    ave = asset_ave
    sum_of_squares = samples.inject(0){|sum, i| sum + (i - ave) ** 2 }
    s2 = sum_of_squares / TRIALS
    s = Math.sqrt(s2).round
  end

  def asset_mean
    a = reports.map(&:total_asset).sort
    mean = (a.size % 2).zero? ? a[a.size/2 - 1, 2].inject(:+) / 2.0 : a[a.size/2]
    mean.round
  end

  def sig(size: 1, symbol: :+)
    asset_ave.send(symbol, asset_sigma.send('*', size))
  end

  def asset_6sigma
    [
      sig(size: 3, symbol: :-),
      sig(size: 2, symbol: :-),
      sig(size: 1, symbol: :-),
      sig(size: 0, symbol: :+),
      sig(size: 1, symbol: :+),
      sig(size: 2, symbol: :+),
      sig(size: 3, symbol: :+),
    ]
  end
end

