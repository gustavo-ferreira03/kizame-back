class AddClassroomToPractices < ActiveRecord::Migration[7.0]
  def change
    add_reference :practices, :classroom, null: false, foreign_key: true
  end
end
