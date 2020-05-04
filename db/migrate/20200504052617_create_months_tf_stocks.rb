class CreateMonthsTfStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :months_tf_stocks do |t|
      t.belongs_to :ticker
      t.belongs_to :month

      t.integer :open
      t.integer :high
      t.integer :low
      t.integer :close
      t.integer :volume

      t.timestamps
    end
  end
end
