class CreateClassroomModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :classroom_modalities do |t|
      t.references :modality, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
