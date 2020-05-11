class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.belongs_to :month_simulation
      t.belongs_to :month
      t.integer :term
      t.integer :total_asset, limit: 8
      t.integer :cash, limit: 8

      t.timestamps
    end
  end
end
