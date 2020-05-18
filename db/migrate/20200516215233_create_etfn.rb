class CreateEtfn < ActiveRecord::Migration[6.0]
  def change
    create_table :etfns do |t|
      t.belongs_to :ticker
      t.belongs_to :month

      t.integer :open
      t.integer :high
      t.integer :low
      t.integer :close
      t.integer :volume, :integer, limit: 8

      t.timestamps
    end
  end
end
