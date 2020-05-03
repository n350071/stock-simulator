class CreateWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :weeks do |t|
      t.date :week_at

      t.timestamps
    end
  end
end
