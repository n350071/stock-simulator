class AddDeletedAtToTicker < ActiveRecord::Migration[6.0]
  def change
    add_column :tickers, :deleted_at, :datetime
    add_index :tickers, :deleted_at
  end
end
