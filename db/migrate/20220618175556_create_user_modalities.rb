class CreateUserModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :user_modalities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :modality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
