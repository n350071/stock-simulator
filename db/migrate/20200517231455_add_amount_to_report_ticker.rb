class AddAmountToReportTicker < ActiveRecord::Migration[6.0]
  def change
    add_column :report_tickers, :amount, :decimal, precision: 10, scale: 3
  end
end
