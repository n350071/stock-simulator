class ChangeMonthsTfStockVolumeToBigint < ActiveRecord::Migration[6.0]
  def change
    add_column :months_tf_stocks, :volume_tmp, :integer, limit: 8
  end
end
