class CreateMonthSimulations < ActiveRecord::Migration[6.0]
  def change
    create_table :month_simulations do |t|
      t.belongs_to :start_month, foreign_key: { to_table: :months}
      t.belongs_to :end_month, foreign_key: { to_table: :months}
      t.integer :badget, limit: 8
      t.string :strategy # 売買戦略モデル

      t.timestamps
    end
  end
end
