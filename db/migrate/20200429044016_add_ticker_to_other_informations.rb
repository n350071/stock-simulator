class AddTickerToOtherInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :tickers, :name_ja, :string
    add_column :tickers, :market, :string
    add_column :tickers, :field33, :integer
    add_column :tickers, :field17, :integer
    add_column :tickers, :scale, :integer
    add_column :tickers, :on_alph, :boolean
  end
end
