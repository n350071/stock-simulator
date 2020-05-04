class CreateTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :tickers do |t|
      t.string :name
      t.string :symbol
      t.integer :market
      t.integer :field33
      t.integer :field17
      t.integer :scale
      t.datetime :reflashed_at

      t.timestamps
    end
  end
end
