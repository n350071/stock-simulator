class RemoveMonthsTfStockVolumeOfTinyInt < ActiveRecord::Migration[6.0]
  def up
    remove_column :months_tf_stocks, :volume
    rename_column :months_tf_stocks, :volume_tmp, :volume
  end

  def down
    rename_column :months_tf_stocks, :volume, :volume_tmp
    add_column :months_tf_stocks, :volume
  end

end
