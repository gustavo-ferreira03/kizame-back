class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :name_teacher
      t.date :day_week
      t.time :time

      t.timestamps
    end
  end
end
