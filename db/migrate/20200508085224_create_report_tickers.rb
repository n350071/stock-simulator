class CreateReportTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :report_tickers do |t|
      t.belongs_to :report
      t.belongs_to :ticker

      t.integer :price, limit: 8
      t.integer :valuation

      t.timestamps
    end
  end
end
