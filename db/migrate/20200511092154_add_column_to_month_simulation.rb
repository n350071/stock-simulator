class AddColumnToMonthSimulation < ActiveRecord::Migration[6.0]
  def change
    add_column :month_simulations, :total_badget, :integer, limit: 8, comment: '累積投入予算'
    add_column :month_simulations, :asset_ave, :integer, comment: '総資産の平均値'
    add_column :month_simulations, :asset_sigma, :integer, comment: '総資産の標準偏差'
    add_column :month_simulations, :asset_mean, :integer, comment: '総資産の中央値'


    add_reference :report_tickers, :month
  end
end
