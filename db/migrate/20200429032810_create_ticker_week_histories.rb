class CreateTickerWeekHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :ticker_week_histories do |t|
      t.belongs_to :ticker
      t.belongs_to :week
      t.integer :open
      t.integer :high
      t.integer :low
      t.integer :close
      t.integer :volume

      t.timestamps
    end
  end
end
