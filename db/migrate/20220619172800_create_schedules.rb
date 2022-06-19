class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :classroom, null: false, foreign_key: true
      t.integer :from_weekday
      t.integer :to_weekday
      t.integer :from_time
      t.integer :to_time

      t.timestamps
    end
  end
end
