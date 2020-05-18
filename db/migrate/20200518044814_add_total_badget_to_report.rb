class AddTotalBadgetToReport < ActiveRecord::Migration[6.0]
  def change
    remove_column :month_simulations, :total_badget, :integer, limit: 8, comment: '累積投入予算'
    add_column :reports, :total_badget, :integer, limit: 8, comment: '累積投入予算'
    add_column :performances, :total_badget, :integer, limit: 8, comment: '累積投入予算'
  end
end
