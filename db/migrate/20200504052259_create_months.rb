class CreateMonths < ActiveRecord::Migration[6.0]
  def change
    create_table :months do |t|
      t.date :month_at

      t.timestamps
    end
  end
end
