class CreateTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :tickers do |t|
      t.string :name
      t.string :symbol
      t.string :time_span
      t.datetime :last_reflashed_at
      t.string :time_zone

      t.timestamps
    end
  end
end
