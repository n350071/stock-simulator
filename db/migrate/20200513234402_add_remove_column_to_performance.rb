class AddRemoveColumnToPerformance < ActiveRecord::Migration[6.0]
  def up
    add_column :performances, :ticker_count, :integer, comment: '保有銘柄数'
  end

  def down
    remove_column :performances, :ticker_count, :integer
  end
end
