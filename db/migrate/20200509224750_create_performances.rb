class CreatePerformances < ActiveRecord::Migration[6.0]
  def change
    create_table :performances do |t|
      t.belongs_to :report
      t.belongs_to :month

      t.integer :total_asset, limit: 8
      t.integer :cash, limit: 8
      t.integer :sum_valuation, comment: '保有銘柄の評価額'
      t.integer :sum_price, comment: '保有銘柄の買付額'

      t.integer :buy, comment: '今月の購入額'
      t.integer :sell, comment: '今月の売却額'

      t.integer :total_buy, comment: '累積の購入額'
      t.integer :total_sell, comment: '累積の売却額'

      t.timestamps
    end
  end
end
