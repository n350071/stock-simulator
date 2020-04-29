class CreateTickerWeekHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :ticker_week_histories do |t|
      t.belongs_to :ticker
      t.integer :open
      t.integer :high
      t.integer :low
      t.integer :close
      t.integer :volue
      t.date :week_at

      t.timestamps
    end
  end
end
