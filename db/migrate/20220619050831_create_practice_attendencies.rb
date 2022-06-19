class CreatePracticeAttendencies < ActiveRecord::Migration[7.0]
  def change
    create_table :practice_attendencies do |t|
      t.references :practice, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
